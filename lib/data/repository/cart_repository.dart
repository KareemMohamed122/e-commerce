import 'package:injectable/injectable.dart';
import 'package:untitled2/domain/entity/product.dart';
import 'package:untitled2/domain/repository/cart_repository.dart';

import '../date_source/local/local_storage.dart';
import '../models/cart_item.dart';

@LazySingleton(as: CartRepository)
class CartRepositoryImp implements CartRepository {
  @override
  void loadCart(Map<Product, int> cart) async {
    cart.clear();
    final items = await LocalStorage.loadData("cartBox");
    for (CartItem cartItem in items.cast<CartItem>()) {
      cart[cartItem.product] = cartItem.quantity;
    }
  }

  @override
  void saveCart(Map<Product, int> cart) {
    LocalStorage.clearBox("cartBox");
    for (var entry in cart.entries) {
      LocalStorage.saveData(
        "cartBox",
        entry.key.id,
        CartItem(product: entry.key, quantity: entry.value),
      );
    }
  }
}
