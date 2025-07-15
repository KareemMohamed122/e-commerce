import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:untitled2/cart_screen/presentation/screens/cart_screen.dart';
import 'package:untitled2/commonUI/custom_appbar.dart';
import 'package:untitled2/commonUI/cart_icon.dart';

import '../../../bloc/product/product_bloc.dart';
import '../../../bloc/product/product_event.dart';
import '../../../bloc/product/product_state.dart';
import '../../../core/injection.dart';
import '../widgets/product_grid.dart';
import '../widgets/category_list.dart';
import '../widgets/featured_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    getIt<ProductBloc>().add(LoadProducts());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (_) => getIt<ProductBloc>()..add(LoadProducts()),
      child: Scaffold(
        appBar: CustomAppbar(
          leading: const Icon(
            Icons.search_outlined,
            color: Colors.black,
            size: 20,
          ),
          title: Image.asset("assets/images/home_images/casaforsa.png"),
          actions: const [
            Icon(Icons.favorite_outline_rounded, color: Colors.black),
            SizedBox(width: 16),
            Icon(Icons.shopping_bag_outlined, color: Colors.black),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/home_images/banner.png",
                width: 375,
                height: 214,
              ),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "All Products",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  Text(
                    "See more",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: Color(0xFF006FFD),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductLoaded) {
                    return ProductGrid(products: state.products);
                  } else if (state is ProductError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
