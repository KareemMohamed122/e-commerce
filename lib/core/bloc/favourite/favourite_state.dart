import 'package:untitled2/domain/entity/product.dart';

abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteUpdated extends FavouriteState {
  final List<Product> items;

  FavouriteUpdated({required this.items});
}
