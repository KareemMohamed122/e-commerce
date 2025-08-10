import 'package:hive/hive.dart';
import '../domain/entity/product.dart';

part 'cart_item.g.dart';

@HiveType(typeId: 1)
class CartItem extends HiveObject {
  @HiveField(0)
  final Product product;

  @HiveField(1)
  final int quantity;

  CartItem({required this.product, required this.quantity});
}
