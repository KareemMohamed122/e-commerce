import '../entity/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getAllProducts({int? offset, int? limit});
  Future<Product> getProductById(int id);
  Future<List<Product>> getFilteredProducts({
    int? categoryId,
    String? categorySlug,
    String? title,
    double? minPrice,
    double? maxPrice,
  });
}
