import 'package:equatable/equatable.dart';
import '../../data/models/product.dart';

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
  final int currentOffset; // Used only for allProducts pagination
  final int limit; // Used only for allProducts pagination
  final bool hasMore; // Used only for allProducts pagination

  const ProductsLoaded({
    required this.allProducts,
    required this.filteredProducts,
    this.category,
    this.minPrice,
    this.maxPrice,
    this.searchText,
    this.sortOption,
    this.currentOffset = 0,
    this.limit = 10,
    this.hasMore = true,
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
    currentOffset,
    limit,
    hasMore,
  ];
}
