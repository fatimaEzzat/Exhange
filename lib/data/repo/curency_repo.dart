import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:exchange/shared/utilities.dart';
import 'package:tuple/tuple.dart';
import '../api/currency_api.dart';
import '../data_models/currency_model.dart';

class CurrencyRepo {
  final CurrencyApi _currencyApi;

  CurrencyRepo(this._currencyApi);

  Future<Tuple2<List<Currency>, String>> getLatestRates(
      {required Map<String, dynamic> queryMap}) async {
    Response response = await _currencyApi.getLatestRates(queryMap: queryMap);
    List<Currency> rates = parseRatesList(response.data['rates']);
    String date = response.data['date'];
    return Tuple2(rates, date);
  }

  Future<List<Currency>> getTimeSeriesData(
      {required String startDate, required String endDate}) async {
    Response response = await _currencyApi.getTimeSeriesData(
        query: {'start_date': startDate, 'end_date': endDate});
    if (response.data['rates'].isNotEmpty) {
      List<Currency> rates = parseRatesList(response.data['rates'][startDate]);
      return rates;
    } else {
      printDebug('error');
      throw 'Error: invalid start or end date';
    }

  }

  Future<List<Currency>> getSupportedSymbols() async {
    Map<String, dynamic> data = await _currencyApi.getSupportedSymbols();
    List<Currency> symbols = parseSymbolsList(data);
    return symbols;
  }

  Future<double> convertCurrency(
      {required String from,
      required String to,
      required String amount}) async {
    Map<String, dynamic> queryMap = {'from': from, 'to': to, 'amount': amount};
    Response response = await _currencyApi.convertCurrency(query: queryMap);
    if (response.data['success'] == true) {
      return response.data['result'];
    } else {
      throw 'Error';
    }
  }
}
