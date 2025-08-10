import 'package:untitled2/domain/entity/product.dart';

abstract class CartEvent {}

class IncrementQuantity extends CartEvent {
  final Product product;
  IncrementQuantity(this.product);
}

class DecrementQuantity extends CartEvent {
  final Product product;
  DecrementQuantity(this.product);
}

class ClearCart extends CartEvent {}

class LoadCart extends CartEvent {}

class RemoveProduct extends CartEvent {
  final Product product;
  RemoveProduct(this.product);
}
