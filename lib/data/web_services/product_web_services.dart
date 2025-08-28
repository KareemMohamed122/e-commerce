import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';
import '../models/product_dto.dart';

part 'product_web_services.g.dart';

@RestApi(baseUrl: "https://ecommerce-app-production-e80c.up.railway.app/")
abstract class ProductWebService {
  @factoryMethod
  factory ProductWebService(Dio dio, {String baseUrl}) = _ProductWebService;

  @GET("products")
  Future<List<ProductDTO>> getAllProducts();

  @GET("products/{id}")
  Future<ProductDTO> getProduct(@Path("id") int id);

  @GET("products/filter")
  Future<List<ProductDTO>> getFilteredProducts({
    @Query("categoryId") int? categoryId,
    @Query("categorySlug") String? categorySlug,
    @Query("title") String? title,
    @Query("price_min") double? minPrice,
    @Query("price_max") double? maxPrice,
  });
}
