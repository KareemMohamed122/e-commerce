import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled2/data/models/category_dto.dart';
import 'package:untitled2/data/repository/category_repository.dart';
import 'package:untitled2/domain/entity/category.dart';

import '../../../domain/repository/category_repository.dart';
import 'category_event.dart';
import 'category_state.dart';

@injectable
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;
  List<Category> categories = [];
  CategoryBloc(this.categoryRepository) : super(CategoryInitial()) {
    on<LoadCategories>((event, emit) async {
      emit(CategoryLoading());
      final categories = await categoryRepository.getAllCategories();
      categories.fold(
        (failure) => emit(CategoryError(failure.message)),
        (product) => emit(CategoriesLoaded(product)),
      );
    });
  }
}
