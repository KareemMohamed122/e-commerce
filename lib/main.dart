import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:untitled2/bloc/cart/cart_bloc.dart';
import 'package:untitled2/models/cart_item.dart';

import 'bloc/cart/cart_event.dart' show LoadCart;
import 'core/injection.dart';
import 'data/models/product.dart';
import 'home_page/presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(CartItemAdapter());
  await Hive.openBox<CartItem>('cartBox');
  setupDependencies();
  final cartBloc = getIt<CartBloc>();
  cartBloc.add(LoadCart());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<CartBloc>(),
      child: GetMaterialApp(
        title: 'My Shop',
        theme: ThemeData(primarySwatch: Colors.
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
