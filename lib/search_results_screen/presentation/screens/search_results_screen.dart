import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/product/product_bloc.dart';
import '../../../bloc/product/product_event.dart';
import '../../../bloc/product/product_state.dart';
import '../../../commonUI/custom_appbar.dart';
import '../../../commonUI/custom_search_bar.dart';
import '../../../commonUI/favourite_cart_icons.dart';
import '../../../commonUI/product_card.dart';
import '../../../commonUI/sort_filter.dart';
import '../../../core/injection.dart';
import '../../../data/models/product.dart';

class SearchResultsScreen extends StatefulWidget {
  final String title;
  const SearchResultsScreen({super.key, required this.title});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final productBloc = getIt<ProductBloc>();
  List<String> recentWords = ["bed", "pillows", "candles"];

  @override
  void initState() {
    super.initState();
    productBloc.add(LoadProductsByTitle(widget.title));
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
            recentWords: recentWords,
            handleSubmit: (String value) {
              setState(() {
                recentWords.add(value);
              });
            },
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
                  BlocBuilder<ProductBloc, ProductState>(
                    bloc: productBloc,
                    builder: (context, state) {
                      if (state is ProductLoading) {
                        return const Center(child: CircularProgressIndicator());
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
                                childAspectRatio: .65,
                              ),
                          itemBuilder: (context, index) {
                            final Product product = products[index];
                            return ProductCard(product: product);
                          },
                        );
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
