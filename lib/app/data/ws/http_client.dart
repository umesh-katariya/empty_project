import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../core/logger/app_logger.dart';
import '../../../core/utils/storage_utils.dart';


class HttpClient {
  String baseUrl;

  HttpClient(this.baseUrl);

  static HttpClient instance(String baseUrl) => HttpClient(baseUrl);
  static const int maxRetryCount = 2;

  Future<HttpResponse> get(
      {required String path,
      dynamic contentType,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      bool isAuthAdd = true,
      int retryCount = 0}) async {
    try {
      Dio dio = await _getDio(contentType: contentType, isAuthAdd: isAuthAdd);

      if (headers != null) {
        dio.options.headers.addAll(headers);
      }
      Response res = await dio.get(path, queryParameters: queryParameters);

      return HttpResponse(res.data, null, statusCode: res.statusCode);
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      if (retryCount < maxRetryCount && e.response?.statusCode == 401) {
        retryCount++;
        String? myNewToken = await FirebaseAuth.instance.currentUser?.getIdToken(true);
        Storage.setAuthToken(myNewToken);
        return await get(
            path: path,
            contentType: contentType,
            headers: headers,
            queryParameters: queryParameters,
            retryCount: retryCount);
      }
      if (retryCount < maxRetryCount && e.type == DioExceptionType.connectionTimeout) {
        retryCount++;
        return await get(
            path: path,
            contentType: contentType,
            headers: headers,
            queryParameters: queryParameters,
            retryCount: retryCount);
      }
      return HttpResponse(null, e, statusCode: e.response?.statusCode);
    }
  }

  Future<HttpResponse> post(
      {required String path,
      dynamic data,
      dynamic contentType,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      bool isPlainText = false,
      int retryCount = 0}) async {
    try {
      Dio dio = await _getDio(contentType: contentType, isPlainText: isPlainText);
      dio.options.headers.addAll(headers ?? {});
      Response res = await dio.post(path, data: data, queryParameters: queryParameters);

      return HttpResponse(res.data, null, statusCode: res.statusCode);
    } on DioException catch (e) {
      if (retryCount < maxRetryCount && e.response?.statusCode == 401) {
        retryCount++;
        String? myNewToken = await FirebaseAuth.instance.currentUser?.getIdToken(true);
        Storage.setAuthToken(myNewToken);
        return await post(
          path: path,
          data: data,
          contentType: contentType,
          headers: headers,
          queryParameters: queryParameters,
          retryCount: retryCount,
        );
      }
      if (retryCount < maxRetryCount && e.type == DioExceptionType.connectionTimeout) {
        retryCount++;
        return await post(
          path: path,
          data: data,
          contentType: contentType,
          headers: headers,
          queryParameters: queryParameters,
          retryCount: retryCount,
        );
      }
      return HttpResponse(null, e, statusCode: e.response?.statusCode);
    }
  }

  Future<HttpResponse> postFormData(
      {required String path,
      FormData? data,
      dynamic contentType,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      Dio dio = await _getDio(contentType: contentType);
      Map<String, dynamic> header = headers ?? {};

      dio.options.headers.addAll(header);
      Response res = await dio.post(path, data: data, queryParameters: queryParameters);
      return HttpResponse(res.data, null, statusCode: res.statusCode);
    } on DioException catch (e) {
      return HttpResponse(null, e, statusCode: e.response?.statusCode);
    }
  }

  Future<HttpResponse> put(
      {required String path,
      dynamic data,
      dynamic contentType,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      int retryCount = 0}) async {
    try {
      Dio dio = await _getDio(contentType: contentType);

      if (headers != null) {
        dio.options.headers.addAll(headers);
      }
      Response res = await dio.put(path, data: data, queryParameters: queryParameters);

      return HttpResponse(res.data, null, statusCode: res.statusCode);
    } on DioException catch (e) {
      if (retryCount < maxRetryCount && e.response?.statusCode == 401) {
        retryCount++;
        String? myNewToken = await FirebaseAuth.instance.currentUser?.getIdToken(true);
        Storage.setAuthToken(myNewToken);
        return await put(
          path: path,
          data: data,
          contentType: contentType,
          headers: headers,
          queryParameters: queryParameters,
          retryCount: retryCount,
        );
      }
      if (retryCount < maxRetryCount && e.type == DioExceptionType.connectionTimeout) {
        retryCount++;
        return await put(
          path: path,
          data: data,
          contentType: contentType,
          headers: headers,
          queryParameters: queryParameters,
          retryCount: retryCount,
        );
      }
      return HttpResponse(null, e, statusCode: e.response?.statusCode);
    }
  }

  Future<HttpResponse> patch(
      {required String path,
      dynamic data,
      dynamic contentType,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      int retryCount = 0}) async {
    try {
      Dio dio = await _getDio(contentType: contentType);
      if (headers != null) {
        dio.options.headers.addAll(headers);
      }
      Response res = await dio.patch(path, data: data, queryParameters: queryParameters);
      return HttpResponse(res.data, null, statusCode: res.statusCode);
    } on DioError catch (e) {
      if (retryCount < maxRetryCount && e.response?.statusCode == 401) {
        retryCount++;
        String? myNewToken = await FirebaseAuth.instance.currentUser?.getIdToken(true);
        Storage.setAuthToken(myNewToken);
        return await patch(
          path: path,
          data: data,
          contentType: contentType,
          headers: headers,
          queryParameters: queryParameters,
          retryCount: retryCount,
        );
      }
      if (retryCount < maxRetryCount && e.type == DioExceptionType.connectionTimeout) {
        retryCount++;
        return await patch(
          path: path,
          data: data,
          contentType: contentType,
          headers: headers,
          queryParameters: queryParameters,
          retryCount: retryCount,
        );
      }
      return HttpResponse(null, e, statusCode: e.response?.statusCode);
    }
  }

  Future<HttpResponse> delete(
      {required String path,
      dynamic data,
      dynamic contentType,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      int retryCount = 0}) async {
    try {
      Dio dio = await _getDio(contentType: contentType);
      if (headers != null) {
        dio.options.headers.addAll(headers);
      }
      Response res = await dio.delete(path, data: data, queryParameters: queryParameters);
      return HttpResponse(res.data, null, statusCode: res.statusCode);
    } on DioException catch (e) {
      if (retryCount < maxRetryCount && e.response?.statusCode == 401) {
        retryCount++;
        String? myNewToken = await FirebaseAuth.instance.currentUser?.getIdToken(true);
        Storage.setAuthToken(myNewToken);
        return await delete(
          path: path,
          data: data,
          contentType: contentType,
          headers: headers,
          queryParameters: queryParameters,
          retryCount: retryCount,
        );
      }
      if (retryCount < maxRetryCount && e.type == DioExceptionType.connectionTimeout) {
        retryCount++;
        return await delete(
          path: path,
          data: data,
          contentType: contentType,
          headers: headers,
          queryParameters: queryParameters,
          retryCount: retryCount,
        );
      }
      return HttpResponse(null, e, statusCode: e.response?.statusCode);
    }
  }

  Future<HttpResponse> downloadFile(
      {required String url, required String savePath, ProgressCallback? onReceiveProgress}) async {
    try {
      Dio dio = Dio();
      dio.options.connectTimeout = const Duration(milliseconds: 30000);
      dio.options.receiveTimeout = const Duration(milliseconds: 30000);
      Response res = await dio.download(url, savePath, onReceiveProgress: onReceiveProgress);
      return HttpResponse(res.data, null, statusCode: res.statusCode);
    } on DioError catch (e) {
      return HttpResponse(null, e, statusCode: e.response?.statusCode);
    }
  }

  HttpResponse _errorResponse(String path) {
    throw const SocketException("No internet connected.");
  }

  Future<Dio> _getDio(
      {dynamic contentType, bool isAuthAdd = true, bool isPlainText = false}) async {
    Dio dio = Dio();
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = const Duration(milliseconds: 30000);
    dio.options.receiveTimeout = const Duration(milliseconds: 30000);
    dio.httpClientAdapter;
    if (contentType != null) {
      dio.options.contentType = contentType;
    }

    var authToken = Storage.getAuthToken();
    if (authToken != null && authToken.isNotEmpty) {
      dio.options.headers.addAll({
        'Content-Type': isPlainText ? 'text/plain' : 'application/json; charset=UTF-8',
        if (isAuthAdd) "Authorization": "Bearer $authToken",
      });
    }

    AppLog.i(json.encode(dio.options.headers));

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        request: true,
        error: true,
      ),
    );

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (options.path.contains('https://storage.googleapis.com') ||
            options.path.contains('https://api.instagram.com')) {
          options.baseUrl = options.path;
          options.path = '';
        }
        if (!options.baseUrl.contains('https://storage.googleapis.com') &&
            !options.path.contains('https://api.instagram.com')) {
          options.headers['Authorization'] = 'Bearer $authToken';
        }
        handler.next(options);
      },
    ));

    return dio;
  }

}

class HttpResponse {
  dynamic data;
  bool status = true;
  int? statusCode;
  String error = 'Something may went wrong';

  HttpResponse(dynamic response, DioError? error, {this.statusCode}) {
    if (error == null) {
      if (response is String) {
        try {
          response = json.decode(response);
        } catch (e) {
          AppLog.d(e);
        }
      } else if (response is Map<String, dynamic>) {
        if (response.containsKey('status')) {
          if (response['status'] == 1) {
            data = response;
            status = true;
            this.error = '';
          } else {
            data = response;
            status = false;
            this.error = response['message'] ?? "error";
          }
        } else {
          data = response;
          status = true;
          this.error = '';
        }
      } else {
        data = response;
        status = true;
        this.error = '';
      }
    } else {
      data = response;
      status = false;
      this.error = getDioError(error);
    }
  }

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }

  String getDioError(DioError? e) {
    if (e != null) {
      return switch (e.type) {
        DioExceptionType.connectionTimeout => 'The connection has timed out',
        DioExceptionType.sendTimeout => 'The connection has timed out',
        DioExceptionType.receiveTimeout => 'The connection has timed out',
        DioExceptionType.cancel => 'The request has cancelled',
        DioExceptionType.badCertificate => 'The request has bad certificate',
        DioExceptionType.badResponse => 'The request bad response',
        DioExceptionType.connectionError => 'The connection error',
        DioExceptionType.unknown => 'The unknown error'
      };
    } else {
      return 'Something may went wrong';
    }
  }
}

Future<HttpResponse> downloadFile(
    {required String url, required String savePath, ProgressCallback? onReceiveProgress}) async {
  try {
    Dio dio = Dio();
    dio.options.connectTimeout = const Duration(milliseconds: 30000);
    dio.options.receiveTimeout = const Duration(milliseconds: 30000);
    Response res = await dio.download(url, savePath, onReceiveProgress: onReceiveProgress);
    return HttpResponse(res.data, null, statusCode: res.statusCode);
  } on DioError catch (e) {
    return HttpResponse(null, e);
  }
}
