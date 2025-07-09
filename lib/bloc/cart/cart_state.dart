import 'package:untitled2/models/product.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final Map<Product, int> items;

  CartUpdated(this.items);
}
