import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled2/dependency_injection/injection.dart';
import 'package:untitled2/domain/entity/product.dart';
import 'package:untitled2/domain/repository/favourite_repository.dart';

import '../../../data/date_source/local/local_storage.dart';
import 'favourite_event.dart';
import 'favourite_state.dart';

@singleton
class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final List<Product> _favourite = [];

  FavouriteBloc() : super(FavouriteInitial()) {
    on<LoadFavourite>((event, emit) async {
      getIt<FavouriteRepository>().loadFavourites(favourite);

      emit(FavouriteUpdated(items: _favourite));
    });

    on<AddToFavourite>((event, emit) {
      _favourite.add(event.product);
      emit(FavouriteUpdated(items: _favourite));
      getIt<FavouriteRepository>().saveFavourites(favourite);
    });

    on<RemoveFromFavourite>((event, emit) {
      _favourite.remove(event.product);
      emit(FavouriteUpdated(items: _favourite));
      getIt<FavouriteRepository>().saveFavourites(favourite);
    });
    on<ClearFavourite>((event, emit) {
      _favourite.clear();
      emit(FavouriteUpdated(items: _favourite));
      getIt<FavouriteRepository>().saveFavourites(favourite);
    });
  }

  List<Product> get favourite => _favourite;
}
