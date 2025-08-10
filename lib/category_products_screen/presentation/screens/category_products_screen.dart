import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:untitled2/data/models/product_dto.dart';

import '../../../core/bloc/product/product_bloc.dart';
import '../../../core/bloc/product/product_event.dart';
import '../../../core/bloc/product/product_state.dart';
import '../../../core/commonUI/custom_appbar.dart';
import '../../../core/commonUI/custom_search_bar.dart';
import '../../../core/commonUI/favourite_cart_icons.dart';
import '../../../core/commonUI/product_card.dart';
import '../../../core/commonUI/sort_filter.dart';
import '../../../core/services/injection.dart';
import '../../../domain/entity/product.dart';
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
    _loadCategoryProducts();
  }

  void _loadCategoryProducts() {
    productBloc.add(UpdateProductFilters(categoryId: widget.categoryID));
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
            onPressed: () => Navigator.pop(context),
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
                productBloc.add(
                  UpdateProductFilters(
                    searchText: value,
                    categoryId: widget.categoryID,
                  ),
                );
                Get.to(() => SearchResultsScreen());
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SortFilter(searchFlag: false),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ProductError) {
                      return Center(child: Text(state.message));
                    } else if (state is ProductsLoaded) {
                      final products = state.filteredProducts;
                      return _buildProductGrid(products);
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductGrid(List<Product> products) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, index) {
        final Product product = products[index];
        return ProductCard(
          product: product,
          onReturn: () {
            _loadCategoryProducts();
          },
        );
      },
    );
  }
}
