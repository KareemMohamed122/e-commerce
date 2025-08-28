import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';
import '../models/category_dto.dart';

part 'category_web_services.g.dart';

@RestApi(baseUrl: "https://ecommerce-app-production-e80c.up.railway.app/")
abstract class CategoryWebServices {
  @factoryMethod
  factory CategoryWebServices(Dio dio, {String baseUrl}) = _CategoryWebServices;

  @GET("categories/category")
  Future<List<CategoryDTO>> getAllCategories();
}
