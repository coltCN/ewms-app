class ResponseData<T> {
  int status;
  String? message;
  T? result;
  ResponseData({required this.status, this.message, this.result});

  factory ResponseData.fromJson(dynamic data) {
    return ResponseData(
      status: data['status'],
      message: data['message'],
      result: data['result'],
    );
  }

  bool success() {
    return status == 200;
  }
}
