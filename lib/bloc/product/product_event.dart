import 'package:untitled2/data/models/product.dart';

abstract class ProductEvent {
  const ProductEvent();
}

class LoadProducts extends ProductEvent {}

class LoadProduct extends ProductEvent {
  final int id;

  LoadProduct(this.id);
}

class LoadProductsByPriceRange extends ProductEvent {
  final double minPrice;
  final double maxPrice;

  LoadProductsByPriceRange({required this.minPrice, required this.maxPrice});
}

class LoadProductsByCategoryName extends ProductEvent {
  final String name;

  LoadProductsByCategoryName(this.name);
}

class LoadProductsByTitle extends ProductEvent {
  final String title;

  LoadProductsByTitle(this.title);
}

class LoadProductsByCategoryId extends ProductEvent {
  final int id;

  LoadProductsByCategoryId(this.id);
}

class LoadSortedProducts extends ProductEvent {
  final String sortOption;
  final List<Product> products;
  LoadSortedProducts(this.sortOption, this.products);
}

class ClearState extends ProductEvent {}
