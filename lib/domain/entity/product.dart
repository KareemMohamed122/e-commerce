import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends Equatable {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final List<String> images;

  @HiveField(5)
  final String categoryName;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.categoryName,
  });

  const Product.empty()
    : id = 0,
      title = '',
      price = 0.0,
      description = '',
      images = const [],
      categoryName = '';

  @override
  List<Object?> get props => [id];
}
