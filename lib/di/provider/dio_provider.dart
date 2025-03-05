import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const _timeout = Duration(seconds: 10);

class DioProvider {
  static Dio configure(
      String baseUrl, {
        bool requestBodyJson = true,
      }) {
    final headers = <String, String>{
      Headers.contentTypeHeader: requestBodyJson
          ? Headers.jsonContentType
          : Headers.formUrlEncodedContentType,
    };
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: _timeout,
        receiveTimeout: _timeout,
        headers: headers,
      ),
    );

    if (!kReleaseMode) {
      _setupLoggingInterceptor(dio);
    }
    _setupHandlerInterceptor(dio);
    return dio;
  }

  static void _setupHandlerInterceptor(Dio dio) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          return handler.next(error);
        },
      ),
    );
  }


  static void _setupLoggingInterceptor(Dio dio) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ),
    );
  }
}
