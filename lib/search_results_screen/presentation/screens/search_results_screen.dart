import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:untitled2/data/models/product_dto.dart';

import '../../../core/bloc/product/product_bloc.dart';
import '../../../core/bloc/product/product_event.dart';
import '../../../core/bloc/product/product_state.dart';
import '../../../core/bloc/search/search_bloc.dart';
import '../../../core/bloc/search/search_event.dart';
import '../../../core/bloc/search/search_state.dart';
import '../../../core/commonUI/custom_appbar.dart';
import '../../../core/commonUI/custom_search_bar.dart';
import '../../../core/commonUI/favourite_cart_icons.dart';
import '../../../core/commonUI/product_card.dart';
import '../../../core/commonUI/sort_filter.dart';
import '../../../core/services/injection.dart';
import '../../../domain/entity/product.dart';

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({super.key});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final productBloc = getIt<ProductBloc>();
  final searchBloc = getIt<SearchBloc>();

  String? _searchQuery;

  @override
  void initState() {
    super.initState();
    searchBloc.add(LoadRecentWords());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: productBloc),
        BlocProvider.value(value: searchBloc),
      ],
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
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, searchState) {
                List<String> recentWords = [];
                if (searchState is RecentWordsUpdated) {
                  recentWords = searchState.recentWords;
                }
                return CustomSearchBar(
                  recentWords: recentWords,
                  handleSubmit: (value) {
                    if (value.trim().isNotEmpty) {
                      _searchQuery = value.trim();
                      searchBloc.add(AddRecentWord(_searchQuery!));
                      productBloc.add(
                        UpdateProductFilters(searchText: _searchQuery),
                      );
                    }
                  },
                  filterByCategory: false,
                  hintText: 'Search products',
                );
              },
            ),
          ),
          actions: const [FavouriteCartIcons()],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SortFilter(searchFlag: true),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is ProductError) {
                      return Center(child: Text(state.message));
                    }
                    if (state is ProductsLoaded) {
                      if (state.filteredProducts.isEmpty) {
                        return const Center(child: Text("No products found"));
                      }
                      return _buildGrid(state.filteredProducts);
                    }
                    return const Center(
                      child: Text("Search for products to see results"),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(List<Product> products) {
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
        final product = products[index];
        return ProductCard(
          product: product,
          onReturn: () {
            if (_searchQuery != null && _searchQuery!.isNotEmpty) {
              productBloc.add(UpdateProductFilters(searchText: _searchQuery));
            }
          },
        );
      },
    );
  }
}
