import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_event.dart';
import '../data/models/product.dart';
import '../models/cart_item.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async {
  getIt.init();
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemAdapter());
  Hive.registerAdapter(ProductAdapter());
}
