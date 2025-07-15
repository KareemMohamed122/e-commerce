import 'package:injectable/injectable.dart';
import '../models/product.dart';
import '../web_services/product_web_services.dart';

@lazySingleton
class ProductRepository {
  final ProductWebService productWebService;

  ProductRepository(this.productWebService);

  Future<List<Product>> fetchAllProducts() async {
    return await productWebService.getAllProducts();
  }
}
