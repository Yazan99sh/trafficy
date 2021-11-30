import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio_firebase_performance/dio_firebase_performance.dart';
import 'package:injectable/injectable.dart';
import 'package:trafficy_client/utils/logger/logger.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

@injectable
class ApiClient {
  final Logger _logger;
  final String tag = 'ApiClient';

  final performanceInterceptor = DioFirebasePerformanceInterceptor();

  ApiClient(this._logger);

  Future<Map<String, dynamic>?> get(
    String url, {
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  }) async {
    try {
      _logger.info(tag, 'Requesting GET to: ' + url);
      _logger.info(tag, 'Headers: ' + headers.toString());
      _logger.info(tag, 'Query: ' + queryParams.toString());
      Dio client = Dio(BaseOptions(
        sendTimeout: 60000,
        receiveTimeout: 60000,
        connectTimeout: 60000,
      ));
      if (!kIsWeb) {
        client.interceptors.add(performanceInterceptor);
      }
      if (headers != null) {
        if (headers['Authorization'] != null) {
          _logger.info(tag, 'Adding Auth Header');
          client.options.headers['Authorization'] = headers['Authorization'];
        }
      }
      //  client.options.headers['Access-Control-Allow-Origin'] = '*';
      var response = await client.get(
        url,
        queryParameters: queryParams,
      );
      return _processResponse(response);
    } catch (e) {
      if (e is DioError) {
        DioError err = e;
        if (err.response != null) {
          if (err.response!.statusCode! < 501) {
            _logger.error(
                tag, err.message + ', GET: ' + url, StackTrace.current);
            return {
              'status_code': '${err.response?.statusCode?.toString() ?? '0'}'
            };
          }
        }
      } else {
        _logger.error(tag, e.toString() + ', GET: ' + url, StackTrace.current);
      }
      return null;
    }
  }

  Future<Map<String, dynamic>?> post(
    String url,
    Map<String, dynamic> payLoad, {
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  }) async {
    Dio client = Dio(BaseOptions(
      sendTimeout: 60000,
      receiveTimeout: 60000,
      connectTimeout: 60000,
    ));
    try {
      _logger.info(tag, 'Requesting Post to: ' + url);
      _logger.info(tag, 'POST: ' + jsonEncode(payLoad));
      _logger.info(tag, 'Headers: ' + jsonEncode(headers));
      if (headers != null) {
        if (headers['Authorization'] != null) {
          _logger.info(tag, 'Adding Auth Header');
          client.options.headers['Authorization'] = headers['Authorization'];
        }
      }
      //  client.options.headers['Access-Control-Allow-Origin'] = '*';
      if (!kIsWeb) {
        client.interceptors.add(performanceInterceptor);
      }
      var response = await client.post(
        url,
        queryParameters: queryParams,
        data: json.encode(payLoad),
      );
      return _processResponse(response);
    } catch (e) {
      if (e is DioError) {
        DioError err = e;
        if (err.response != null) {
          if (err.response!.statusCode! < 501) {
            _logger.error(
                tag, err.message + ', POST: ' + url, StackTrace.current);
            return {
              'status_code': '${err.response?.statusCode?.toString() ?? '0'}'
            };
          }
        }
      } else {
        _logger.error(tag, e.toString() + ', POST: ' + url, StackTrace.current);
        return null;
      }
    }
  }

  Future<Map<String, dynamic>?> put(
    String url,
    Map<String, dynamic> payLoad, {
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  }) async {
    try {
      _logger.info(tag, 'Requesting PUT to: ' + url);
      _logger.info(tag, 'PUT: ' + jsonEncode(payLoad));
      _logger.info(tag, 'Headers: ' + jsonEncode(headers));
      Dio client = Dio(BaseOptions(
        sendTimeout: 60000,
        receiveTimeout: 60000,
        connectTimeout: 60000,
      ));

      if (headers != null) {
        if (headers['Authorization'] != null) {
          _logger.info(tag, 'Adding Auth Header');
          client.options.headers['Authorization'] = headers['Authorization'];
        }
      }
      //  client.options.headers['Access-Control-Allow-Origin'] = '*';
      if (!kIsWeb) {
        client.interceptors.add(performanceInterceptor);
      }
      var response = await client.put(
        url,
        queryParameters: queryParams,
        data: json.encode(payLoad),
        options: Options(headers: headers),
      );
      return _processResponse(response);
    } catch (e) {
      if (e is DioError) {
        DioError err = e;
        if (err.response != null) {
          if (err.response!.statusCode! < 501) {
            _logger.error(
                tag, err.message + ', PUT: ' + url, StackTrace.current);
            return {
              'status_code': '${err.response?.statusCode?.toString() ?? '0'}'
            };
          }
        }
      } else {
        _logger.error(tag, e.toString() + ', PUT: ' + url, StackTrace.current);
      }
      return null;
    }
  }

  Future<Map<String, dynamic>?> delete(
    String url, {
    Map<String, String>? queryParams,
    Map<String, String>? headers,
  }) async {
    try {
      _logger.info(tag, 'Requesting DELETE to: ' + url);
      _logger.info(tag, 'Headers: ' + headers.toString());
      _logger.info(tag, 'Query: ' + queryParams.toString());
      Dio client = Dio(BaseOptions(
        sendTimeout: 60000,
        receiveTimeout: 60000,
        connectTimeout: 60000,
      ));
      if (!kIsWeb) {
        client.interceptors.add(performanceInterceptor);
      }
      if (headers != null) {
        if (headers['Authorization'] != null) {
          _logger.info(tag, 'Adding Auth Header');
          client.options.headers['Authorization'] = headers['Authorization'];
        }
      }
      //   client.options.headers['Access-Control-Allow-Origin'] = '*';
      var response = await client.delete(
        url,
        queryParameters: queryParams,
      );
      return _processResponse(response);
    } catch (e) {
      if (e is DioError) {
        DioError err = e;
        if (err.response!.statusCode != 404) {
          _logger.error(
              tag, err.message + ', DELETE: ' + url, StackTrace.current);
        }
      } else {
        _logger.error(
            tag, e.toString() + ', DELETE: ' + url, StackTrace.current);
      }
      return null;
    }
  }

  Map<String, dynamic>? _processResponse(Response response) {
    if (response.statusCode! < 500) {
      _logger.info(tag, response.data.toString());
      return response.data;
    } else {
      _logger.error(
          tag,
          response.statusCode.toString() + '\n\n' + response.data.toString(),
          StackTrace.current);
      return null;
    }
  }
}
