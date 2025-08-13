import '../entity/product.dart';

abstract class CartRepository {
  void saveCart(Map<Product, int> cart);
  void loadCart(Map<Product, int> cart);
}
