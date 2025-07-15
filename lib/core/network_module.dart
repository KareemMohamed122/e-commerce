import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../data/web_services/product_web_services.dart';

@module
abstract class WebServiceModule {
  @lazySingleton
  Dio get dio => Dio();

  @lazySingleton
  ProductWebService provideProductWebService(Dio dio) {
    return ProductWebService(dio);
  }
}
