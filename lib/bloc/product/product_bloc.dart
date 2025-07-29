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
  }

  List<Product> get products => _products;

  set products(List<Product> value) {
    _products = value;
  }
}
