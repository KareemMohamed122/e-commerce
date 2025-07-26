import 'package:injectable/injectable.dart';
import 'package:untitled2/data/models/category.dart';
import 'package:untitled2/data/web_services/category_web_services.dart';

@lazySingleton
class CategoryRepository {
  final CategoryWebServices categoryWebServices;

  CategoryRepository(this.categoryWebServices);

  Future<List<CategoryModel>> fetchAllCategories() async {
    return await categoryWebServices.getAllCategories();
  }
}
