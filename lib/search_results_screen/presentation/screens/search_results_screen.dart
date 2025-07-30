import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/search/search_bloc.dart';
import '../../../bloc/search/search_event.dart';
import '../../../bloc/search/search_state.dart';
import '../../../commonUI/custom_appbar.dart';
import '../../../commonUI/custom_search_bar.dart';
import '../../../commonUI/favourite_cart_icons.dart';
import '../../../commonUI/product_card.dart';
import '../../../commonUI/sort_filter.dart';
import '../../../core/injection.dart';
import '../../../data/models/product.dart';

class SearchResultsScreen extends StatefulWidget {
  final String title;
  final bool filterByCategory;
  final int? categoryID;
  final List<String> recentWords;
  const SearchResultsScreen({
    super.key,
    required this.title,
    required this.filterByCategory,
    this.categoryID,
    required this.recentWords,
  });

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final searchBloc = getIt<SearchBloc>();

  @override
  void initState() {
    super.initState();
    widget.filterByCategory
        ? searchBloc.add(
          LoadProductsByTitleAndCategory(widget.title, widget.categoryID!),
        )
        : searchBloc.add(LoadProductsByTitle(widget.title));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            recentWords: widget.recentWords,
            handleSubmit: (String value) {
              setState(() {
                searchBloc.add(AddRecentWord(value));
              });
            },
            filterByCategory: widget.filterByCategory,
          ),
        ),
        actions: const [FavouriteCartIcons()],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.all(16.0), child: SortFilter()),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  BlocBuilder<SearchBloc, SearchState>(
                    bloc: searchBloc,
                    builder: (context, state) {
                      if (state is ProductsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ProductError) {
                        return Center(child: Text(state.message));
                      } else if (state is ProductsLoaded) {
                        final products = state.products;

                        if (products.isNotEmpty) {
                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: products.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                  childAspectRatio: .65,
                                ),
                            itemBuilder: (context, index) {
                              final Product product = products[index];
                              return ProductCard(product: product);
                            },
                          );
                        } else {
                          return Center(
                            child: Text(
                              "No Products Found",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          );
                        }
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
