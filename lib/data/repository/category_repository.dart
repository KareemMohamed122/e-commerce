import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../core/error/failure.dart';
import '../../core/error/handlers.dart';
import '../../domain/entity/category.dart';
import '../../domain/repository/category_repository.dart';
import '../date_source/remote/category_remote_data_source.dart';

@LazySingleton(as: CategoryRepository)
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Category>>> getAllCategories() async {
    try {
      final dtoList = await remoteDataSource.getAllCategories();
      final categories = dtoList.map((dto) => dto.toEntity()).toList();
      return Right(categories);
    } catch (e, st) {
      return Left(handleError(e, st));
    }
  }
}
