import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';

part 'auth_web_service.g.dart';

@RestApi(baseUrl: "https://ecommerce-app-production-e80c.up.railway.app/")
abstract class AuthWebService {
  @factoryMethod
  factory AuthWebService(Dio dio, {String baseUrl}) = _AuthWebService;

  @POST("auth/login")
  Future<LoginResponse> login(@Body() Map<String, dynamic> body);
}

class LoginResponse {
  final String token;

  LoginResponse({required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(token: json["token"]);
  }
}
