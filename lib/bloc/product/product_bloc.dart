import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled2/bloc/product/product_event.dart';
import 'package:untitled2/bloc/product/product_state.dart';
import 'package:untitled2/core/sort_list.dart';

import '../../data/models/product.dart';
import '../../data/repository/product_repository.dart';

@lazySingleton
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  List<Product> _products = [];
  Product _product = Product.empty();

  ProductBloc(this.productRepository) : super(ProductInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        _products = await productRepository.fetchAllProducts();
        emit(ProductsLoaded(_products));
        // emit(ProductInitial());
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
    on<LoadProduct>((event, emit) async {
      emit(ProductLoading());
      try {
        _product = await productRepository.fetchAProductById(event.id);
        emit(ProductLoaded(_product));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    on<LoadSortedProducts>((event, emit) {
      emit(ProductLoading());
      try {
        _products = SortList.sortList(event.products, event.sortOption);
        emit(ProductsLoaded(_products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
    on<LoadProductsByPriceRange>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await productRepository.fetchAllProductsByPriceRange(
          event.minPrice,
          event.maxPrice,
        );
        emit(ProductsLoaded(products));
      } catch (e) {
        emit(ProductError("Error loading products by price range."));
      }
    });

    on<LoadProductsByTitle>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await productRepository.fetchAllProductsByTitle(
          event.title,
        );
        emit(ProductsLoaded(products));
      } catch (e) {
        emit(ProductError("Error loading products by price range."));
      }
    });
    on<LoadProductsByCategoryName>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await productRepository.fetchAllProductsByCategoryName(
          event.name,
        );
        emit(ProductsLoaded(products));
      } catch (e) {
        emit(ProductError("Error loading products by Category."));
      }
    });
    on<LoadProductsByCategoryId>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await productRepository.fetchAllProductsByCategoryId(
          event.id,
        );
        emit(ProductsLoaded(products));
      } catch (e) {
        emit(ProductError("Error loading products by Category."));
      }
    });
    on<ClearState>((event, emit) async {
      emit(ProductInitial());
    });
  }

  List<Product> get products => _products;

  set products(List<Product> value) {
    _products = value;
  }
}
