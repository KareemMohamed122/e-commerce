import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled2/bloc/cart/cart_event.dart';
import 'package:untitled2/bloc/cart/cart_state.dart';
import 'package:untitled2/models/product.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final Map<Product, int> _cart = {};

  CartBloc() : super(CartInitial()) {
    on<LoadCart>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      final cartList = prefs.getStringList('cart') ?? [];
      Map<Product, int> loadedCart = {};

      for (String item in cartList) {
        final decoded = jsonDecode(item);
        final product = Product.fromJson(decoded['product']);
        final quantity = decoded['quantity'];
        loadedCart[product] = quantity;
      }

      _cart.clear();
      _cart.addAll(loadedCart);
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
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartList =
        _cart.entries.map((entry) {
          final productJson = entry.key.toJson();
          final quantity = entry.value;
          return jsonEncode({'product': productJson, 'quantity': quantity});
        }).toList();
    await prefs.setStringList('cart', cartList);
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
    final double price = product.price ?? 0.0;
    return price * quantity;
  }
}
