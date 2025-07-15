import '../../data/models/product.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final Product product;
  AddToCart(this.product);
}

class RemoveFromCart extends CartEvent {
  final Product product;
  RemoveFromCart(this.product);
}

class ClearCart extends CartEvent {}

class LoadCart extends CartEvent {}

class RemoveAllFromCart extends CartEvent {
  final Product product;
  RemoveAllFromCart(this.product);
}
