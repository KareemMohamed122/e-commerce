import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:untitled2/commonUI/custom_appbar.dart';

import '../../../bloc/product/product_bloc.dart';
import '../../../bloc/product/product_event.dart';
import '../../../bloc/product/product_state.dart';
import '../../../commonUI/favourite_cart_icons.dart';
import '../../../commonUI/featured_banner.dart';
import '../../../commonUI/products_heading.dart';
import '../../../core/injection.dart';
import '../widgets/product_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (_) => getIt<ProductBloc>()..add(LoadProducts()),
      child: Scaffold(
        appBar: CustomAppbar(
          height: 72,
          leading: const Icon(
            Icons.search_outlined,
            color: Color(0xFF2F3036),
            size: 20,
          ),
          title: Image.asset("assets/images/home_images/casaforsa.png"),
          actions: const [FavouriteCartIcons()],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FeaturedBanner(
                imgList: [
                  'assets/images/home_images/banner_one.jpg',
                  'assets/images/home_images/banner_two.jpg',
                  'assets/images/home_images/banner_three.jpg',
                ],
                height: 214,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductsHeading(),
                    const SizedBox(height: 16),
                    BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                        if (state is ProductLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is ProductsLoaded) {
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
            ],
          ),
        ),
      ),
    );
  }
}
