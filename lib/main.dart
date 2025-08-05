import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:untitled2/bloc/favourite/favourite_bloc.dart';
import 'package:untitled2/bloc/favourite/favourite_event.dart';
import 'package:untitled2/bloc/product/product_bloc.dart';
import 'package:untitled2/bloc/product/product_event.dart';
import 'bloc/search/search_bloc.dart';
import 'bloc/search/search_event.dart';
import 'core/injection.dart';
import 'bloc/cart/cart_bloc.dart';
import 'bloc/category/category_bloc.dart';
import 'bloc/category/category_event.dart';
import 'commonUI/navigation_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<CartBloc>()),
        BlocProvider.value(value: getIt<FavouriteBloc>()),

        BlocProvider(create: (_) => getIt<ProductBloc>()..add(LoadProducts())),
        BlocProvider(
          create: (_) => getIt<CategoryBloc>()..add(LoadCategories()),
        ),
      ],
      child: GetMaterialApp(
        title: 'My Shop',
        theme: ThemeData(
          fontFamily: 'inter',
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: NavigationBarMenu(currentIndex: 0),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
