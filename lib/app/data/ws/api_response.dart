import 'dart:convert';

import 'http_client.dart';

class APIResponse<T> {
  bool success;
  String? message;
  String? token;
  T? data;
  int? totalRecords;
  int? unreadCount;
  int? statusCode;
  bool? isRegistered;

  APIResponse({
    required this.success,
    this.message,
    this.data,
    this.token,
    this.unreadCount,
    this.statusCode,
    this.totalRecords,
    this.isRegistered,
  });

  factory APIResponse.fromHttpResponse(HttpResponse response,
      {Function? fromJsonModel}) {
    bool isSuccess = response.status;
    String? message = response.error;
    int? statusCode = response.statusCode;
    T? data;
    String? token;
    int? totalRecords;
    int? unreadCount;
    bool? isRegistered;

    if (response.data != null && response.data is Map) {
      // if (response.data.containsKey('statusCode') &&
      //     response.data['statusCode'] is int) {
      //   isSuccess = response.data['statusCode'] == 200;
      if (response.data.containsKey('error') &&
          response.data['error'] is bool &&
          response.data['error']) {
        isSuccess = false;
      }

      if (response.data.containsKey('message')) {
        message = response.data['message'];
      }

      if (fromJsonModel != null) {
        data = fromJsonModel(response.data);
      } else {
        data = response.data;
      }

      // }
    }else if(response.data != null && response.data is List){
      if (fromJsonModel != null) {
        data = fromJsonModel(response.data);
      } else {
        data = response.data;
      }
    }

    return APIResponse(
      success: isSuccess,
      message: message,
      data: data,
      token: token,
      unreadCount: unreadCount,
      totalRecords: totalRecords,
      isRegistered: isRegistered,
      statusCode: statusCode
    );
  }

  @override
  String toString() {
    return json.encode({
      'status': success,
      'message': message,
      'data': data,
      'token': token,
    });
  }
}
