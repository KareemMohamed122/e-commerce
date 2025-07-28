import 'package:untitled2/data/models/product.dart';

abstract class ProductEvent {
  const ProductEvent();
}

class LoadProducts extends ProductEvent {}

class LoadProduct extends ProductEvent {
  final int id;

  LoadProduct(this.id);
}

class LoadProductsByCategory extends ProductEvent {
  final int categoryId;

  LoadProductsByCategory(this.categoryId);
}

class LoadProductsByTitle extends ProductEvent {
  final String title;

  LoadProductsByTitle(this.title);
}

class LoadSortedProducts extends ProductEvent {
  final String sortOption;
  final List<Product> products;
  LoadSortedProducts(this.sortOption, this.products);
}
