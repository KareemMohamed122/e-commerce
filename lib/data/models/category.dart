import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'category.g.dart';

@JsonSerializable()
class CategoryModel extends Equatable {
  late int id;
  late String image;
  late String slug;

  CategoryModel(this.id, this.image, this.slug);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  @override
  List<Object> get props => [id];
}
