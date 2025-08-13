import 'package:injectable/injectable.dart';

import '../../../domain/entity/product.dart';
import '../../models/product_dto.dart';
import '../../web_services/product_web_services.dart';

@lazySingleton
class ProductRemoteDataSource {
  final ProductWebService productWebService;

  ProductRemoteDataSource(this.productWebService);
  Future<List<ProductDTO>> getAllProducts({int? offset, int? limit}) async {
    final dtoList = await productWebService.getAllProducts(
      offset: offset,
      limit: limit,
    );
    return dtoList;
  }

  Future<ProductDTO> getProductById(int id) async {
    final dto = await productWebService.getProduct(id);
    return dto;
  }

  Future<List<ProductDTO>> getFilteredProducts({
    int? categoryId,
    String? categorySlug,
    String? title,
    double? minPrice,
    double? maxPrice,
  }) async {
    final dtoList = await productWebService.getFilteredProducts(
      categoryId: categoryId,
      categorySlug: categorySlug,
      title: title,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );
    return dtoList;
  }
}
