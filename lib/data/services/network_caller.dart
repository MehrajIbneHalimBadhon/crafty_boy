import 'dart:convert';
import 'package:get/get.dart' as getx;
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import '../../presentation/Ui/screens/email_verification_screen.dart';
import '../../presentation/state_holders/auth_controller.dart';
import '../models/network_response.dart';

class NetworkCaller {
  final Logger logger;
  final AuthController authController;

  NetworkCaller({required this.logger, required this.authController});

  Future<NetworkResponse> getRequest({required String url, String? token}) async {
    Uri uri = Uri.parse(url);
    _requestLog(url, {}, {}, AuthController.accessToken ?? '');
    final Response response = await get(uri, headers: {
      'token': '${token ?? AuthController.accessToken}',
    });

    try {
      if (response.statusCode == 200) {
        _responseLog(
            url, response.statusCode, response.body, response.headers, true);
        final decodeBody = jsonDecode(response.body);
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            responseData: decodeBody);
      } else {
        _responseLog(
            url, response.statusCode, response.body, response.headers, false);
        if (response.statusCode == 401) {
          _moveToLogin();
        }
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      _responseLog(url, -1, null, {}, false, e);
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    Uri uri = Uri.parse(url);
    _requestLog(url, {}, body ?? {}, AuthController.accessToken ?? '');
    final Response response = await post(uri, body: jsonEncode(body), headers: {
      'token': '${AuthController.accessToken}',
      'content-type': 'application/json'
    });

    try {
      if (response.statusCode == 200) {
        _responseLog(
            url, response.statusCode, response.body, response.headers, true);
        final decodedBody = jsonDecode(response.body);
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true,
            responseData: decodedBody);
      } else {
        _responseLog(
            url, response.statusCode, response.body, response.headers, false);
        if (response.statusCode == 401) {
          _moveToLogin();
        }
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch (e) {
      _responseLog(url, -1, null, {}, false, e);
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }


  void _requestLog(String url, Map<String, dynamic> params,
      Map<String, dynamic> body, String token) {
    logger.i('''
    Url: $url
    Params: $params
    Body: $body,
    Token: $token
    ''');
  }

  void _responseLog(String url, int statusCode, dynamic responseBody,
      Map<String, dynamic> headers, bool isSuccess,
      [dynamic error]) {
    String message = '''
    Url: $url
    Status Code: $statusCode
    Headers: $headers,
    Response Body: $responseBody,
    Error: $error,
    ''';
    if (isSuccess) {
      logger.i(message);
    } else {
      logger.e(message);
    }
  }

  Future<void> _moveToLogin() async {
    await authController.clearUserData();
    getx.Get.to(const EmailVerificationScreen());
  }
}
