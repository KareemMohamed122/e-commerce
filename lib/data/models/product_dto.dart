// lib/data/models/product_dto.dart
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/product.dart';

part 'product_dto.g.dart';

@JsonSerializable()
class ProductDTO {
  final int id;
  final String title;
  final double price;
  final String description;
  final List<String> images;

  final String categoryName;

  ProductDTO({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.categoryName,
  });

  factory ProductDTO.fromJson(Map<String, dynamic> json) =>
      _$ProductDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDTOToJson(this);

  Product toEntity() {
    return Product(
      id: id,
      title: title,
      price: price,
      description: description,
      images: images,
      categoryName: categoryName,
    );
  }

  factory ProductDTO.fromEntity(Product entity) {
    return ProductDTO(
      id: entity.id,
      title: entity.title,
      price: entity.price,
      description: entity.description,
      images: entity.images,
      categoryName: entity.categoryName,
    );
  }
}
