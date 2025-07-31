import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:untitled2/bloc/product/product_bloc.dart';
import 'package:untitled2/bloc/product/product_event.dart';
import 'package:untitled2/bloc/product/product_state.dart';
import 'package:untitled2/commonUI/add_to_cart_quantity.dart';
import 'package:untitled2/commonUI/custom_appbar.dart';
import 'package:untitled2/commonUI/product_card.dart';
import 'package:untitled2/commonUI/sort_filter.dart';
import 'package:untitled2/data/models/product.dart';
import '../../../commonUI/custom_search_bar.dart';
import '../../../commonUI/favourite_cart_icons.dart';
import '../../../core/injection.dart';
import '../../../search_results_screen/presentation/screens/search_results_screen.dart';

class CategoryProductsScreen extends StatefulWidget {
  final int categoryID;
  const CategoryProductsScreen({super.key, required this.categoryID});

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  final productBloc = getIt<ProductBloc>();
  List<String> recentWords = [];

  @override
  void initState() {
    super.initState();
    productBloc.add(LoadProductsByCategoryId(widget.categoryID));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: productBloc,
      child: Scaffold(
        appBar: CustomAppbar(
          height: 72,
          leading: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF0019FF),
              size: 20,
            ),
          ),
          title: SizedBox(
            height: 44,
            child: CustomSearchBar(
              handleSubmit: (String value) {
                setState(() {
                  recentWords.add(value);
                });
                productBloc.add(LoadProductsByTitle(value));
                Get.to(() => const SearchResultsScreen());
              },
              filterByCategory: true,
              categoryID: widget.categoryID,
              recentWords: recentWords,
            ),
          ),
          actions: const [FavouriteCartIcons()],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(16.0), child: SortFilter()),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                        if (state is ProductLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is ProductError) {
                          return Center(child: Text(state.message));
                        } else if (state is ProductsLoaded) {
                          final products = state.products;
                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: products.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: 0.65,
                                ),
                            itemBuilder: (context, index) {
                              final Product product = products[index];
                              return ProductCard(product: product);
                            },
                          );
                        }
                        return const SizedBox();
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
