import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled2/data/web_services/category_web_services.dart';
import 'package:untitled2/data/web_services/login_web_services.dart';
import '../../data/web_services/product_web_services.dart';

class TokenStorage {
  static String? token;
}

@module
abstract class WebServiceModule {
  @lazySingleton
  Dio get dio {
    final dio = Dio();

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = TokenStorage.token;
          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
      ),
    );

    return dio;
  }

  @lazySingleton
  ProductWebService provideProductWebService(Dio dio) {
    return ProductWebService(dio);
  }

  @lazySingleton
  CategoryWebServices provideCategoryWebService(Dio dio) {
    return CategoryWebServices(dio);
  }

  @lazySingleton
  AuthWebService provideAuthWebService(Dio dio) {
    return AuthWebService(dio);
  }
}
