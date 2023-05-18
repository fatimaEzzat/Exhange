import 'package:dio/dio.dart';
import 'package:exchange/data/api/currency_api.dart';
import 'package:exchange/data/data_models/currency_model.dart';
import 'package:exchange/data/repo/curency_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'currency_repo_test.mocks.dart';

@GenerateMocks([CurrencyApi])
void main() {
  late CurrencyRepo currencyRepo;
  late CurrencyApi mockCurrencyApi;

  setUp(() {
    mockCurrencyApi = MockCurrencyApi();
    currencyRepo = CurrencyRepo(mockCurrencyApi);
  });

  test('get supported symbols without any errors', () async {
    // Arrange
    List<Currency> symbols =
        List.generate(5, (index) => Currency(code: '$index', data: '$index'));

    Map<String, dynamic> symbolsMap = parseListToMap(items:symbols);

    // Mock the API response
    when(mockCurrencyApi.getSupportedSymbols())
        .thenAnswer((_) => Future.value(symbolsMap));

    // Act
    List<Currency> actualSymbols = await currencyRepo.getSupportedSymbols();

    // Assert
    expect(actualSymbols, symbols);
  });

  test('convert Currency returns the converted amount if successful', () async {
    // Arrange
    String from = 'USD';
    String to = 'EUR';
    String amount = '100';
    double expectedResult = 85.23;

    Map<String, dynamic> queryMap = {'from': from, 'to': to, 'amount': amount};
    Response successResponse = Response(
        data: {'success': true, 'result': expectedResult},
        requestOptions: RequestOptions());

    when(mockCurrencyApi.convertCurrency(query: queryMap))
        .thenAnswer((_) => Future.value(successResponse));

    // Act
    double result =
        await currencyRepo.convertCurrency(from: from, to: to, amount: amount);

    // Assert
    expect(result, expectedResult);
    verify(mockCurrencyApi.convertCurrency(query: queryMap));
  });

  test('convertCurrency throws an error if conversion fails', () async {
    // Arrange
    String from = 'USD';
    String to = 'EUR';
    String amount = '100';

    Map<String, dynamic> queryMap = {'from': from, 'to': to, 'amount': amount};
    Response failureResponse = Response(data: {'success': false}, requestOptions: RequestOptions(
    ));

    when(mockCurrencyApi.convertCurrency(query: queryMap))
        .thenAnswer((_) => Future.value(failureResponse));

    // Act and Assert
    expect(
        () => currencyRepo.convertCurrency(from: from, to: to, amount: amount),
        throwsA('Error'));

  });

  test('get Time Series Data  without any errors', () async {
    String startDate = '2023-01-01';
    String endDate = '2023-01-04';
    List<Currency> expectedRates =
    List.generate(5, (index) => Currency(code: '$index', data: '$index'));


    Map<String, dynamic> queryMap = {'start_date': startDate, 'end_date': endDate};
    Response successResponse = Response(
        data: {'success': true, 'rates': parseListToMap( items:expectedRates,startDate: startDate)},
        requestOptions: RequestOptions());

    when(mockCurrencyApi.getTimeSeriesData(query: queryMap))
        .thenAnswer((_) => Future.value(successResponse));

    // Act
    List<Currency> actualRates =
    await currencyRepo.getTimeSeriesData(startDate: startDate, endDate: endDate);

    // Assert
    expect(actualRates, expectedRates);
  });

  test('get Time Series Data should throw error when enter invalid start or end date', () async {
    // Arrange..provide invalid dates
    String startDate = '2023-06-22';
    String endDate = '2023-06-02';


    Map<String, dynamic> queryMap = {'start_date': startDate, 'end_date': endDate};
    Response failureResponse = Response(data: {'success': true,'rates':{}}, requestOptions: RequestOptions(
    ));

    when(mockCurrencyApi.getTimeSeriesData(query: queryMap))
        .thenAnswer((_) => Future.value(failureResponse));

    // Act and Assert
    expect(
            () => currencyRepo.getTimeSeriesData(startDate: startDate, endDate: endDate),
        throwsA('Error: invalid start or end date'));

  });
}
