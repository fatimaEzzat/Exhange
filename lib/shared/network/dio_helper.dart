import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../constants.dart';


class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: baseUrl,
          receiveDataWhenStatusError: true,
          validateStatus: (status) => true, //TODO: only in dev
          /* validateStatus: (status) {
            return status! < 500;
          },*/
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 3),
      // 30 seconds
      ),
    );
  }

  static Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? query,

  }) async {
    try {
      Response res = await dio.get(
        endPoint,
        queryParameters: query,
      );
      if (res.statusCode != 401) {
        return res;
      } else {
        //401 UnAuthorized
        throw 'UnAuthorized';
      }
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.connectionTimeout) {
        throw
        "time_out"; //TODO: change to custom exception class
      } else if (ex.type == DioErrorType.receiveTimeout) {
        throw "time_out";
      } else {
        debugPrint('exType: ${ex.type}');
        throw 'checkNet';
      }
    }
  }

}
