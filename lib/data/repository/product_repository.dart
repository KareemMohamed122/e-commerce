import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failure.dart';
import '../../core/error/handlers.dart';
import '../../domain/entity/product.dart';
import '../../domain/repository/product_repository.dart';
import '../date_source/remote/product_remote_data_source.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRepositoryImpl(this.productRemoteDataSource);

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final dtoList = await productRemoteDataSource.getAllProducts();
      final entities = dtoList.map((dto) => dto.toEntity()).toList();
      return Right(entities);
    } catch (e, st) {
      return Left(handleError(e, st));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(int id) async {
    try {
      final dto = await productRemoteDataSource.getProductById(id);
      return Right(dto.toEntity());
    } catch (e, st) {
      return Left(handleError(e, st));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getFilteredProducts({
    int? categoryId,
    String? categorySlug,
    String? title,
    double? minPrice,
    double? maxPrice,
  }) async {
    try {
      final dtoList = await productRemoteDataSource.getFilteredProducts(
        categoryId: categoryId,
        categorySlug: categorySlug,
        title: title,
        minPrice: minPrice,
        maxPrice: maxPrice,
      );
      final entities = dtoList.map((dto) => dto.toEntity()).toList();
      return Right(entities);
    } catch (e, st) {
      return Left(handleError(e, st));
    }
  }
}
