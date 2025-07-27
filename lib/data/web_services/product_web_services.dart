import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:injectable/injectable.dart';
import '../models/product.dart';

part 'product_web_services.g.dart';

@RestApi(baseUrl: "https://api.escuelajs.co/api/v1/")
abstract class ProductWebService {
  @factoryMethod
  factory ProductWebService(Dio dio, {String baseUrl}) = _ProductWebService;

  @GET("products")
  Future<List<Product>> getAllProducts();

  @GET("products/{id}")
  Future<Product> getProduct(@Path("id") int id);

  @GET("products")
  Future<List<Product>> getProductsByCategory(
    @Query("categoryId") int categoryId,
  );
}
