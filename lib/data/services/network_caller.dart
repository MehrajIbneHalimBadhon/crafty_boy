import 'dart:convert';

import 'package:http/http.dart';
import 'package:logger/logger.dart';

import '../models/network_response.dart';

class NetworkCaller {
  final Logger logger;

  NetworkCaller({required this.logger});

  Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      _requestLog(url, {}, {}, '');

      final Response response = await get(uri, headers: {
        'token': '',
      });

      if (response.statusCode == 200) {
        _responseLog(
            url, response.statusCode, response.headers, response.body, true);
        final decodeBody = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodeBody,
        );
      } else {
        _responseLog(
            url, response.statusCode, response.headers, response.body, false);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      _responseLog(url, -1, {}, e, true, e);
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      _requestLog(url, {}, body ?? {}, '');
      final Response response = await post(
        uri,
        headers: {
          'token': '',
          'content-type': 'application/json',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        _responseLog(
            url, response.statusCode, response.headers, response.body, true);
        final decodeBody = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodeBody,
        );
      } else {
        _responseLog(
            url, response.statusCode, response.headers, response.body, false);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      _responseLog(url, -1, {}, e, true, e);
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  void _requestLog(String url, Map<String, dynamic> params,
      Map<String, dynamic> body, String token) {
    logger.i('''
    URL: $url,
    Params: $params,
    Body: $body,
    Token: $token
    
    ''');
  }

  void _responseLog(String url, int statusCode, Map<String, dynamic> headers,
      dynamic responseBody, bool isSuccess,
      [dynamic error]) {
    String message = '''
    URL: $url,
    Status Code: $statusCode,
    Headers: $headers
    Response Body: $responseBody
    Error: $error
    
    ''';
    if (isSuccess) {
      logger.i(message);
    } else {
      logger.e(message);
    }
  }
}
