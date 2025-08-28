import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../entity/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();

  Future<Either<Failure, Product>> getProductById(int id);

  Future<Either<Failure, List<Product>>> getFilteredProducts({
    int? categoryId,
    String? categorySlug,
    String? title,
    double? minPrice,
    double? maxPrice,
  });
}
