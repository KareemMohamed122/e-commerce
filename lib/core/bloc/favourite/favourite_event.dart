import 'package:untitled2/domain/entity/product.dart';

abstract class FavouriteEvent {}

class AddToFavourite extends FavouriteEvent {
  final Product product;

  AddToFavourite({required this.product});
}

class RemoveFromFavourite extends FavouriteEvent {
  final Product product;

  RemoveFromFavourite({required this.product});
}

class ClearFavourite extends FavouriteEvent {}

class LoadFavourite extends FavouriteEvent {}
