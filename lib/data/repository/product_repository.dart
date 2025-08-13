import 'package:injectable/injectable.dart';
import 'package:untitled2/data/date_source/remote/product_remote_data_source.dart';
import '../../domain/entity/product.dart';
import '../../domain/repository/product_repository.dart';
import '../web_services/product_web_services.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;
 
  ProductRepositoryImpl(this.productRemoteDataSource);

  @override
  Future<List<Product>> getAllProducts({int? offset, int? limit}) async {
    final dtoList = await productRemoteDataSource.getAllProducts(
      offset: offset,
      limit: limit,
    );
    return dtoList.map((dto) => dto.toEntity()).toList();
  }

  @override
  Future<Product> getProductById(int id) async {
    final dto = await productRemoteDataSource.getProductById(id);
    return dto.toEntity();
  }

  @override
  Future<List<Product>> getFilteredProducts({
    int? categoryId,
    String? categorySlug,
    String? title,
    double? minPrice,
    double? maxPrice,
  }) async {
    final dtoList = await productRemoteDataSource.getFilteredProducts(
      categoryId: categoryId,
      categorySlug: categorySlug,
      title: title,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );
    return dtoList.map((dto) => dto.toEntity()).toList();
  }
}
