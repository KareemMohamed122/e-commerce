import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled2/bloc/category/category_event.dart';
import 'package:untitled2/bloc/category/category_state.dart';
import 'package:untitled2/data/models/category.dart';
import 'package:untitled2/data/repository/category_repository.dart';

@injectable
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;
  List<CategoryModel> categories = [];
  CategoryBloc(this.categoryRepository) : super(CategoryInitial()) {
    on<LoadCategories>((event, emit) async {
      emit(CategoryLoading());
      try {
        categories = await categoryRepository.fetchAllCategories();
        emit(CategoriesLoaded(categories));
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });
  }
}
