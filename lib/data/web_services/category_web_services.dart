import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled2/data/models/category.dart';
import '../models/product.dart';

part 'category_web_services.g.dart';

@RestApi(baseUrl: "https://api.escuelajs.co/api/v1/")
abstract class CategoryWebServices {
  @factoryMethod
  factory CategoryWebServices(Dio dio, {String baseUrl}) = _CategoryWebServices;

  @GET("categories")
  Future<List<CategoryModel>> getAllCategories();
}
