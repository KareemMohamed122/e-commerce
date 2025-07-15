import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Product {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final int price;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final List<String> images;

  @HiveField(5)
  @JsonKey(name: 'category', fromJson: extractCategoryName)
  final String categoryName;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.categoryName,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  static String extractCategoryName(dynamic category) {
    return category['name'] ?? '';
  }
}
