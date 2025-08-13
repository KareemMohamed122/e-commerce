import 'package:injectable/injectable.dart';
import 'package:untitled2/data/web_services/category_web_services.dart';

import '../../models/category_dto.dart';

@lazySingleton
class CategoryRemoteDataSource {
  final CategoryWebServices categoryWebService;

  CategoryRemoteDataSource(this.categoryWebService);

  Future<List<CategoryDTO>> getAllCategories() async {
    final dtoList = await categoryWebService.getAllCategories();
    return dtoList;
  }
}
