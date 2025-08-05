import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/bloc/favourite/favourite_bloc.dart';
import 'package:untitled2/bloc/favourite/favourite_event.dart';
import 'package:untitled2/bloc/favourite/favourite_state.dart';
import 'package:untitled2/core/injection.dart';
import '../../../commonUI/label_widget.dart';
import '../../../data/models/product.dart';

class FavouriteProducts extends StatefulWidget {
  const FavouriteProducts({super.key, required this.items});

  final List<Product> items;

  @override
  State<FavouriteProducts> createState() => _FavouriteProductsState();
}

class _FavouriteProductsState extends State<FavouriteProducts> {
  // @override
  // void initState() {
  //   getIt<FavouriteBloc>().add(LoadFavourite());
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.items.length,
      itemBuilder: (_, index) {
        final product = widget.items[index];

        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    product.images[0],
                    width: 90,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LabelWidget(
                          label: product.title,
                          labelColor: const Color(0xFF1F2024),
                          labelFontSize: 14,
                          labelFontWeight: FontWeight.w700,
                          widget: Text(
                            product.categoryName,
                            style: const TextStyle(
                              color: Color(0xFF71727A),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 9),
                        Text(
                          "€ ${product.price}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1F2024),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<FavouriteBloc, FavouriteState>(
                  builder: (context, favState) {
                    bool isFavourite = false;
                    if (favState is FavouriteUpdated) {
                      isFavourite = favState.items.contains(product);
                    }

                    return IconButton(
                      icon: Icon(
                        isFavourite ? Icons.favorite : Icons.favorite_outline,
                        color: const Color(0xFF0019FF),
                      ),
                      onPressed: () {
                        if (isFavourite) {
                          getIt<FavouriteBloc>().add(
                            RemoveFromFavourite(product: product),
                          );
                        } else {
                          getIt<FavouriteBloc>().add(
                            AddToFavourite(product: product),
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (_, __) {
        return const Divider(color: Color(0xFFD4D6DD));
      },
    );
  }
}
