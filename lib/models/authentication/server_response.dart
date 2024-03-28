import 'package:cydeva_application/models/authentication/data.dart';

class ServerResponse {
  final int statusCode;
  final String message;
  final Data data;

  ServerResponse(
      {required this.statusCode, required this.message, required this.data});

  factory ServerResponse.fromJson(Map<String, dynamic> json) {
    return ServerResponse(
      statusCode: json['status_code'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }
}
