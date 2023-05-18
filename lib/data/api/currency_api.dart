import 'dart:developer';

import 'package:exchange/shared/constants.dart';

import '../../shared/network/dio_helper.dart';

class CurrencyApi{

  Future<dynamic> getLatestRates({
        required Map<String, dynamic> queryMap}) async {
    var response = await DioHelper.getData(
        endPoint: latestRatesEndpoint, query: queryMap);
    log('getLatestRates: ${response.data.toString()}');
    return response;
  }

  Future<Map<String,dynamic>> getSupportedSymbols() async {
    var response = await DioHelper.getData(
        endPoint: supportedSymbols);
    log('getSupportedSymbols: ${response.data.toString()}');
    return response.data['symbols'];
  }

  Future<dynamic> convertCurrency({required Map<String,dynamic> query}) async {
    var response = await DioHelper.getData(
        endPoint: convertCurrencyEndpoint,query: query);
    log('convertCurrency: ${response.data.toString()}');
    return response;
  }

  Future<dynamic> getTimeSeriesData({required Map<String,dynamic> query}) async {
    var response = await DioHelper.getData(
        endPoint: timeSeriesDataEndpoint,query: query);
    log('getHistoricalRates: ${response.data.toString()}');
    return response;
  }
}