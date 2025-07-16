import 'package:equatable/equatable.dart';
import '../../data/models/product.dart';

abstract class ProductState {
  const ProductState();
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<Product> products;

  const ProductsLoaded(this.products);
}

class ProductLoaded extends ProductState {
  final Product product;

  const ProductLoaded(this.product);
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);
}
