import 'package:untitled2/data/models/category_dto.dart';
import 'package:untitled2/domain/entity/category.dart';

abstract class CategoryState {
  CategoryState();
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoriesLoaded extends CategoryState {
  final List<Category> categories;

  CategoriesLoaded(this.categories);
}

class CategoryError extends CategoryState {
  final String message;

  CategoryError(this.message);
}
