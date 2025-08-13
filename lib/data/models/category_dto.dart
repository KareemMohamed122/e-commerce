import 'package:json_annotation/json_annotation.dart';
import '../../domain/entity/category.dart';

part 'category_dto.g.dart';

@JsonSerializable()
class CategoryDTO {
  final int id;
  final String image;
  final String slug;

  CategoryDTO({required this.id, required this.image, required this.slug});

  factory CategoryDTO.fromJson(Map<String, dynamic> json) =>
      _$CategoryDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDTOToJson(this);

  Category toEntity() {
    return Category(id: id, image: image, slug: slug);
  }

  factory CategoryDTO.fromEntity(Category entity) {
    return CategoryDTO(id: entity.id, image: entity.image, slug: entity.slug);
  }
}
