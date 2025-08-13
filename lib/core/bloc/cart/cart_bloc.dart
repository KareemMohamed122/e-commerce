import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled2/dependency_injection/injection.dart';
import 'package:untitled2/domain/entity/product.dart';
import 'package:untitled2/data/models/cart_item.dart';
import 'package:untitled2/domain/repository/cart_repository.dart';

import 'cart_event.dart';
import 'cart_state.dart';

@singleton
class CartBloc extends Bloc<CartEvent, CartState> {
  final Map<Product, int> _cart = {};

  CartBloc() : super(CartInitial()) {
    on<LoadCart>((event, emit) async {
      getIt<CartRepository>().loadCart(_cart);
      emit(CartUpdated(_cart));
    });

    on<IncrementQuantity>((event, emit) {
      _cart.update(
        event.product,
        (quantity) => quantity + 1,
        ifAbsent: () => 1,
      );
      emit(CartUpdated(_cart));
      _saveCart();
    });

    on<DecrementQuantity>((event, emit) {
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

    on<RemoveProduct>((event, emit) {
      _cart.remove(event.product);
      emit(CartUpdated(_cart));
      _saveCart();
    });
  }
  void _saveCart() {
    getIt<CartRepository>().saveCart(_cart);
  }

  int get totalQuantity => _cart.values.fold(0, (sum, item) => sum + item);

  double get totalPrice {
    double total = 0;
    _cart.forEach((product, quantity) {
      total += (product.price) * quantity;
    });
    return total;
  }

  Map<Product, int> get getItems => _cart;

  double getProductTotal(Product product) {
    final int quantity = _cart[product] ?? 0;
    final double price = product.price.toDouble();
    return price * quantity;
  }
}
