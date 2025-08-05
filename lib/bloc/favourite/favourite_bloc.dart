import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled2/bloc/cart/cart_event.dart';
import 'package:untitled2/bloc/cart/cart_state.dart';
import 'package:untitled2/bloc/favourite/favourite_event.dart';
import 'package:untitled2/bloc/favourite/favourite_state.dart';
import 'package:untitled2/core/local_storage.dart';

import '../../data/models/product.dart';

@singleton
class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final List<Product> _favourite = [];

  FavouriteBloc() : super(FavouriteInitial()) {
    on<LoadFavourite>((event, emit) async {
      _favourite.clear();
      final items = await LocalStorage.loadData("favouriteBox");
      for (Product product in items) {
        _favourite.add(product);
      }
      emit(FavouriteUpdated(items: _favourite));
    });

    on<AddToFavourite>((event, emit) {
      _favourite.add(event.product);
      emit(FavouriteUpdated(items: _favourite));
      _saveCart();
    });

    on<RemoveFromFavourite>((event, emit) {
      _favourite.remove(event.product);
      emit(FavouriteUpdated(items: _favourite));
      _saveCart();
    });
    on<ClearFavourite>((event, emit) {
      _favourite.clear();
      emit(FavouriteUpdated(items: _favourite));
      _saveCart();
    });
  }
  void _saveCart() {
    log("item added");
    LocalStorage.clearBox("favouriteBox");
    for (var item in _favourite) {
      LocalStorage.saveData("favouriteBox", item.id, item);
    }
  }

  List<Product> get favourite => _favourite;
}
