import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_event.dart';
import '../data/models/product.dart';
import '../models/cart_item.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Hive.initFlutter();
  //Hive.registerAdapter(ProductAdapter());
  //Hive.registerAdapter(CartItemAdapter());
  // await Hive.openBox<CartItem>('cartBox');

  getIt.init();

  //final cartBloc = getIt<CartBloc>();
  //cartBloc.add(LoadCart());
}
