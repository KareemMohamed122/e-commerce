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
}
