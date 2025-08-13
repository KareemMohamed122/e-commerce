import '../entity/product.dart';

abstract class FavouriteRepository {
  void saveFavourites(List<Product> favourite);
  void loadFavourites(List<Product> favourite);
}
