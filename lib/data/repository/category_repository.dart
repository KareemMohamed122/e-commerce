import 'package:injectable/injectable.dart';
import '../../domain/entity/category.dart';
import '../../domain/repository/category_repository.dart';
import '../web_services/category_web_services.dart';

@LazySingleton(as: CategoryRepository)
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryWebServices categoryWebServices;

  CategoryRepositoryImpl(this.categoryWebServices);

  @override
  Future<List<Category>> getAllCategories() async {
    final dtoList = await categoryWebServices.getAllCategories();
    return dtoList.map((dto) => dto.toEntity()).toList();
  }
}
