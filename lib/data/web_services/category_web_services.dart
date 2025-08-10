import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';
import '../models/category_dto.dart';

part 'category_web_services.g.dart';

@RestApi(baseUrl: "https://api.escuelajs.co/api/v1/")
abstract class CategoryWebServices {
  @factoryMethod
  factory CategoryWebServices(Dio dio, {String baseUrl}) = _CategoryWebServices;

  @GET("categories")
  Future<List<CategoryDTO>> getAllCategories();
}
