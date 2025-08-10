import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';
import '../models/product_dto.dart';

part 'product_web_services.g.dart';

@RestApi(baseUrl: "https://api.escuelajs.co/api/v1/")
abstract class ProductWebService {
  @factoryMethod
  factory ProductWebService(Dio dio, {String baseUrl}) = _ProductWebService;

  @GET("products")
  Future<List<ProductDTO>> getAllProducts({
    @Query("offset") int? offset,
    @Query("limit") int? limit,
  });

  @GET("products/{id}")
  Future<ProductDTO> getProduct(@Path("id") int id);

  @GET("products")
  Future<List<ProductDTO>> getFilteredProducts({
    @Query("categoryId") int? categoryId,
    @Query("categorySlug") String? categorySlug,
    @Query("title") String? title,
    @Query("price_min") double? minPrice,
    @Query("price_max") double? maxPrice,
  });
}
