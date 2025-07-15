import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled2/bloc/product/product_event.dart';
import 'package:untitled2/bloc/product/product_state.dart';

import '../../data/models/product.dart';
import '../../data/repository/product_repository.dart';

@injectable
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  List<Product> _products = [];

  ProductBloc(this.productRepository) : super(ProductInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        _products = await productRepository.fetchAllProducts();
        emit(ProductLoaded(_products));
      } catch (e) {
        emit(const ProductError('Failed to load products'));
      }
    });
  }

  List<Product> get products => _products;
}
