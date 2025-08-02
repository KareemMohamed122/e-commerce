import 'package:injectable/injectable.dart';
import '../web_services/product_web_services.dart';
import '../models/product.dart';

@lazySingleton
class ProductRepository {
  final ProductWebService productWebService;

  ProductRepository(this.productWebService);

  Future<List<Product>> fetchAllProducts() async {
    return await productWebService.getAllProducts();
  }

  Future<Product> fetchAProductById(int id) async {
    return await productWebService.getProduct(id);
  }

  Future<List<Product>> fetchFilteredProducts({
    int? categoryId,
    String? categorySlug,
    String? title,
    double? minPrice,
    double? maxPrice,
  }) async {
    return await productWebService.getFilteredProducts(
      categoryId: categoryId,
      categorySlug: categorySlug,
      title: title,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );
  }
}
