import 'package:injectable/injectable.dart';
import 'package:untitled2/data/date_source/remote/category_remote_data_source.dart';
import '../../domain/entity/category.dart';
import '../../domain/repository/category_repository.dart';
import '../web_services/category_web_services.dart';

@LazySingleton(as: CategoryRepository)
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource categoryRemoteDataSource;

  CategoryRepositoryImpl(this.categoryRemoteDataSource);

  @override
  Future<List<Category>> getAllCategories() async {
    final dtoList = await categoryRemoteDataSource.getAllCategories();
    return dtoList.map((dto) => dto.toEntity()).toList();
  }
}
