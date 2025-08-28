import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductEvent {
  const LoadProducts();
}

class LoadProduct extends ProductEvent {
  final int id;

  const LoadProduct(this.id);

  @override
  List<Object?> get props => [id];
}

class UpdateProductFilters extends ProductEvent {
  final int? categoryId;
  final String? categorySlug;
  final String? searchText;
  final double? minPrice;
  final double? maxPrice;
  final String? sortOption;

  const UpdateProductFilters({
    this.categoryId,
    this.categorySlug,
    this.searchText,
    this.minPrice,
    this.maxPrice,
    this.sortOption,
  });

  @override
  List<Object?> get props => [
    categoryId,
    categorySlug,
    searchText,
    minPrice,
    maxPrice,
    sortOption,
  ];
}

class SortProducts extends ProductEvent {
  final String sortOption;

  const SortProducts(this.sortOption);

  @override
  List<Object?> get props => [sortOption];
}

class ClearState extends ProductEvent {}
