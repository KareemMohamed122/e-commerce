import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/bloc/cart/cart_event.dart';
import 'package:untitled2/bloc/cart/cart_state.dart';
import 'package:untitled2/models/product.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final Map<Product, int> _cart = {};

  CartBloc() : super(CartInitial()) {
    on<AddToCart>((event, emit) {
      _cart.update(
        event.product,
        (quantity) => quantity + 1,
        ifAbsent: () => 1,
      );
      emit(CartUpdated({..._cart}));
    });
    on<RemoveFromCart>((event, emit) {
      if (_cart.containsKey(event.product)) {
        if (_cart[event.product]! > 1) {
          _cart[event.product] = _cart[event.product]! - 1;
        } else {
          _cart.remove(event.product);
        }
      }
      emit(CartUpdated({..._cart}));
    });
    on<ClearCart>((event, emit) {
      _cart.clear();
      emit(CartUpdated({..._cart}));
    });
  }

  int get totalQuantity {
    int total = _cart.values.fold(0, (sum, item) => sum + item);
    return total;
  }

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
