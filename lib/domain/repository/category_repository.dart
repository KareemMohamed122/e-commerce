import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../entity/category.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getAllCategories();
}
