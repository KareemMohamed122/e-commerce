import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled2/bloc/cart/cart_event.dart';
import 'package:untitled2/bloc/cart/cart_state.dart';
import 'package:untitled2/models/cart_item.dart';

import '../../data/models/product.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  final Map<Product, int> _cart = {};

  CartBloc() : super(CartInitial()) {
    on<LoadCart>((event, emit) async {
      final box = Hive.box<CartItem>('cartBox');
      _cart.clear();
      for (CartItem cartItem in box.values) {
        _cart[cartItem.product] = cartItem.quantity;
      }
      emit(CartUpdated(_cart));
    });

    on<AddToCart>((event, emit) {
      _cart.update(
        event.product,
        (quantity) => quantity + 1,
        ifAbsent: () => 1,
      );
      emit(CartUpdated(_cart));
      _saveCart();
    });

    on<RemoveFromCart>((event, emit) {
      if (_cart.containsKey(event.product)) {
        if (_cart[event.product]! > 1) {
          _cart[event.product] = _cart[event.product]! - 1;
        } else {
          _cart.remove(event.product);
        }
        emit(CartUpdated(_cart));
        _saveCart();
      }
    });

    on<ClearCart>((event, emit) {
      _cart.clear();
      emit(CartUpdated(_cart));
      _saveCart();
    });

    on<RemoveAllFromCart>((event, emit) {
      _cart.remove(event.product);
      emit(CartUpdated(_cart));
      _saveCart();
    });
  }
  Future<void> _saveCart() async {
    final box = Hive.box<CartItem>('cartBox');
    await box.clear();
    for (var entry in _cart.entries) {
      box.put(
        entry.key.id,
        CartItem(product: entry.key, quantity: entry.value),
      );
    }
  }

  int get totalQuantity => _cart.values.fold(0, (sum, item) => sum + item);

  double get totalPrice {
    double total = 0;
    _cart.forEach((product, quantity) {
      total += (product.price ?? 0.0) * quantity;
    });
    return total;
  }

  Map<Product, int> get getItems => _cart;

  double getProductTotal(Product product) {
    final int quantity = _cart[product] ?? 0;
    final double price = product.price.toDouble() ?? 0.0;
    return price * quantity;
  }
}
