import 'package:equatable/equatable.dart';
import '../../../domain/entity/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final Product product;

  const ProductLoaded(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductsLoaded extends ProductState {
  final List<Product> allProducts;
  final List<Product> filteredProducts;
  final String? category;
  final double? minPrice;
  final double? maxPrice;
  final String? searchText;
  final String? sortOption;

  const ProductsLoaded({
    required this.allProducts,
    required this.filteredProducts,
    this.category,
    this.minPrice,
    this.maxPrice,
    this.searchText,
    this.sortOption,
  });

  @override
  List<Object?> get props => [
    allProducts,
    filteredProducts,
    category,
    minPrice,
    maxPrice,
    searchText,
    sortOption,
  ];
}
