import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:untitled2/presentation/signin_screen/presentation/screens/signin.dart';

import 'core/commonUI/navigation_bar.dart';
import 'core/bloc/cart/cart_bloc.dart';
import 'core/bloc/category/category_bloc.dart';
import 'core/bloc/category/category_event.dart';
import 'core/bloc/favourite/favourite_bloc.dart';
import 'core/bloc/product/product_bloc.dart';
import 'dependency_injection/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<CartBloc>()),
        BlocProvider(create: (_) => getIt<FavouriteBloc>()),
        BlocProvider(create: (_) => getIt<ProductBloc>()),
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
        //  home: NavigationBarMenu(currentIndex: 0),
        home: SignIn(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
