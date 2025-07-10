import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String? img;
  final String? productName;
  final double? price;
  final String? color;
  final String? details;

  const Product(
    this.img,
    this.productName,
    this.price,
    this.color,
    this.details,
  );

  Map<String, dynamic> toJson() => {
    'img': img,
    'productName': productName,
    'price': price,
    'color': color,
    'details': details,
  };

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    json['img'],
    json['productName'],
    json['price'],
    json['color'],
    json['details'],
  );

  @override
  List<Object?> get props => [productName, price];
}
