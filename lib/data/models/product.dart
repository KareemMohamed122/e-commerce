import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Product extends Equatable {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late double price;

  @HiveField(3)
  late String description;

  @HiveField(4)
  late List<String> images;

  @HiveField(5)
  @JsonKey(name: 'category', fromJson: extractCategoryName)
  late String categoryName;

  @HiveField(6)
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool isFavourite;
  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.categoryName,
    this.isFavourite = false,
  });
  Product.empty()
    : id = 0,
      title = '',
      price = 0.0,
      description = '',
      images = [],
      categoryName = '',
      isFavourite = false;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  static String extractCategoryName(dynamic category) {
    return category['name'] ?? '';
  }

  @override
  List<Object> get props => [id];
}
