import 'package:equatable/equatable.dart';
import '../../data/models/product.dart';

abstract class SearchState {
  SearchState();
}

class SearchInitial extends SearchState {}

class ProductsLoading extends SearchState {}

class ProductsLoaded extends SearchState {
  final List<Product> products;

  ProductsLoaded(this.products);
}

class ProductError extends SearchState {
  final String message;

  ProductError(this.message);
}

class RecentWordsUpdated extends SearchState {
  final List<String> recentWords;
  RecentWordsUpdated(this.recentWords);
}
