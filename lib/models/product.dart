import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String? img;

  @HiveField(2)
  final String? productName;

  @HiveField(3)
  final double? price;

  @HiveField(4)
  final String? color;

  @HiveField(5)
  final String? details;

  Product(
    this.id,
    this.img,
    this.productName,
    this.price,
    this.color,
    this.details,
  );

  @override
  List<Object?> get props => [id];
}
