import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entity/product.dart';
import '../../data/models/cart_item.dart';

import '../bloc/favourite/favourite_bloc.dart';
import '../bloc/favourite/favourite_event.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async {
  getIt.init();
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemAdapter());
  Hive.registerAdapter(ProductAdapter());
  getIt<FavouriteBloc>().add(LoadFavourite());
}
