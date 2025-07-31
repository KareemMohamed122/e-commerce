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

  Future<List<Product>> fetchAllProductsByCategoryId(int id) async {
    return await productWebService.getProductsByCategory(id);
  }

  Future<List<Product>> fetchAllProductsByTitle(String title) async {
    return await productWebService.getProductsByTitle(title);
  }

  Future<List<Product>> fetchAllProductsByTitleAndCategory(
    String title,
    int id,
  ) async {
    return await productWebService.getProductsByTitleAndCategory(title, id);
  }

  Future<List<Product>> fetchAllProductsByPriceRange(
    double price_min,
    double price_max,
  ) async {
    return await productWebService.getProductsByPriceRange(
      price_min,
      price_max,
    );
  }

  Future<List<Product>> fetchAllProductsByCategoryName(String name) async {
    return await productWebService.getProductsByCategoryName(name);
  }
}
