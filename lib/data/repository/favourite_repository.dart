import 'package:injectable/injectable.dart';
import 'package:untitled2/domain/entity/product.dart';

import '../../domain/repository/favourite_repository.dart';
import '../date_source/local/local_storage.dart';

@LazySingleton(as: FavouriteRepository)
class FavouriteRepositoryImp implements FavouriteRepository {
  @override
  void loadFavourites(List<Product> favourite) async {
    favourite.clear();
    final items = await LocalStorage.loadData("favouriteBox");
    for (Product product in items) {
      favourite.add(product);
    }
  }

  @override
  void saveFavourites(List<Product> favourite) {
    LocalStorage.clearBox("favouriteBox");
    for (var item in favourite) {
      LocalStorage.saveData("favouriteBox", item.id, item);
    }
  }
}
