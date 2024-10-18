class NetworkResponse {
  final int statusCode;
  dynamic responseData;
  String? errorMessage;
  final bool isSuccess;

  NetworkResponse(
      {required this.isSuccess,
      required this.statusCode,
      this.responseData,
      this.errorMessage = 'Something went wrong'});
}
