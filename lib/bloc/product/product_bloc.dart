import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled2/bloc/product/product_event.dart';
import 'package:untitled2/bloc/product/product_state.dart';
import 'package:untitled2/core/sort_list.dart';
import '../../data/models/product.dart';
import '../../data/repository/product_repository.dart';

@singleton
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  List<Product> _lastAllProducts = [];
  List<Product> _lastFilteredFromAPI = [];
  List<Product> _currentVisibleList = [];

  String? _lastCategorySlug;
  double? _lastMinPrice;
  double? _lastMaxPrice;
  String? _lastSearchText;
  String? _lastSortOption;

  ProductBloc(this.productRepository) : super(ProductInitial()) {
    on<LoadProduct>((event, emit) async {
      emit(ProductLoading());
      try {
        final product = await productRepository.fetchAProductById(event.id);
        emit(ProductLoaded(product));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await productRepository.fetchAllProducts();
        _lastAllProducts = products;
        _lastFilteredFromAPI = products;
        _currentVisibleList = products;

        emit(ProductsLoaded(allProducts: products, filteredProducts: products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    on<UpdateProductFilters>((event, emit) async {
      emit(ProductLoading());
      try {
        final filtered = await productRepository.fetchFilteredProducts(
          categoryId: event.categoryId,
          categorySlug: event.categorySlug,
          title: event.searchText,
          minPrice: event.minPrice,
          maxPrice: event.maxPrice,
        );

        _lastFilteredFromAPI = filtered;
        _lastCategorySlug = event.categorySlug;
        _lastMinPrice = event.minPrice;
        _lastMaxPrice = event.maxPrice;
        _lastSearchText = event.searchText;
        _lastSortOption = event.sortOption;

        List<Product> sortedList = filtered;
        if (event.sortOption != null && event.sortOption!.isNotEmpty) {
          sortedList = SortList.sortList(sortedList, event.sortOption!);
        }

        _currentVisibleList = sortedList;

        emit(
          ProductsLoaded(
            allProducts: _lastAllProducts,
            filteredProducts: _currentVisibleList,
            category: _lastCategorySlug,
            minPrice: _lastMinPrice,
            maxPrice: _lastMaxPrice,
            searchText: _lastSearchText,
            sortOption: _lastSortOption,
          ),
        );
      } catch (e) {
        emit(ProductError("Error filtering products: ${e.toString()}"));
      }
    });

    on<SortProducts>((event, emit) {
      if (_lastFilteredFromAPI.isEmpty) {
        emit(ProductError("No products to sort."));
        return;
      }

      _lastSortOption = event.sortOption;

      final sorted = SortList.sortList(_lastFilteredFromAPI, event.sortOption);
      _currentVisibleList = sorted;

      emit(
        ProductsLoaded(
          allProducts: _lastAllProducts,
          filteredProducts: _currentVisibleList,
          category: _lastCategorySlug,
          minPrice: _lastMinPrice,
          maxPrice: _lastMaxPrice,
          searchText: _lastSearchText,
          sortOption: _lastSortOption,
        ),
      );
    });

    on<ClearState>((event, emit) {
      _lastAllProducts = [];
      _lastFilteredFromAPI = [];
      _currentVisibleList = [];
      _lastCategorySlug = null;
      _lastMinPrice = null;
      _lastMaxPrice = null;
      _lastSearchText = null;
      _lastSortOption = null;
      emit(ProductInitial());
    });
  }
}
