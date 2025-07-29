import 'package:untitled2/data/models/product.dart';

abstract class SearchEvent {
  SearchEvent();
}

class LoadProducts extends SearchEvent {}

class LoadProductsByCategory extends SearchEvent {
  final int categoryId;

  LoadProductsByCategory(this.categoryId);
}

class LoadProductsByTitle extends SearchEvent {
  final String title;

  LoadProductsByTitle(this.title);
}

class LoadProductsByTitleAndCategory extends SearchEvent {
  final String title;
  final int id;

  LoadProductsByTitleAndCategory(this.title, this.id);
}

class AddRecentWord extends SearchEvent {
  final String word;

  AddRecentWord(this.word);
}

class RemoveRecentWord extends SearchEvent {
  final String word;

  RemoveRecentWord(this.word);
}

class LoadRecentWords extends SearchEvent {
  LoadRecentWords();
}

class LoadSortedProducts extends SearchEvent {
  final String sortOption;
  final List<Product> products;
  LoadSortedProducts(this.sortOption, this.products);
}
