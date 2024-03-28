import 'package:cydeva_application/models/authentication/server_response.dart';
import 'package:cydeva_application/utils/constrant.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'API.g.dart';

@RestApi(baseUrl: Constrant.baseURL)
abstract class API {
  factory API(Dio dio, {String baseUrl}) = _API;

  @POST('/api/v1/auth/verify/otp/')
  Future<ServerResponse> verifyOTP(@Body() Map<String, dynamic> mapJson);
}
