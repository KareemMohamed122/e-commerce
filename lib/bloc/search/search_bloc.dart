import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled2/bloc/search/search_event.dart';
import 'package:untitled2/bloc/search/search_state.dart';
import 'package:untitled2/core/sort_list.dart';

import '../../data/models/product.dart';
import '../../data/repository/product_repository.dart';

@singleton
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ProductRepository productRepository;

  List<Product> _products = [];
  List<String> _recentWords = [];
  SearchBloc(this.productRepository) : super(SearchInitial()) {
    on<AddRecentWord>((event, emit) async {
      if (!_recentWords.contains(event.word)) {
        _recentWords.add(event.word);
        emit(RecentWordsUpdated(_recentWords));
      }
    });

    on<RemoveRecentWord>((event, emit) async {
      _recentWords.remove(event.word);
      emit(RecentWordsUpdated(_recentWords));
    });

    on<LoadRecentWords>((event, emit) async {
      emit(RecentWordsUpdated(_recentWords));
    });
  }
  List<Product> get products => _products;

  set products(List<Product> value) {
    _products = value;
  }
}
