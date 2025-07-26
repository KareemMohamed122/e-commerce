import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'core/injection.dart';
import 'bloc/cart/cart_bloc.dart';
import 'bloc/category/category_bloc.dart';
import 'bloc/category/category_event.dart';
import 'home_page/presentation/screens/home_screen.dart';
import 'profile_page/presentation/screens/profile_screen.dart';
import 'category_screen/presentation/screens/category_screen.dart';
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
        home: const NavigationBarMenu(
          pages: [
            HomeScreen(),
            ProfileScreen(),
            CategoryScreen(),
            Text("Favourites"),
          ],
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
