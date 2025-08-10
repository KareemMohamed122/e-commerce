import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../domain/entity/product.dart';
import '../bloc/favourite/favourite_bloc.dart';
import '../bloc/favourite/favourite_event.dart';
import '../bloc/favourite/favourite_state.dart';
import '../services/product_details_navigation.dart';
import '../services/injection.dart';
import 'add_to_cart_quantity.dart';
import 'label_widget.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onReturn;

  const ProductCard({super.key, required this.product, required this.onReturn});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 241,
      child: InkWell(
        onTap: () {
          openProductDetails(productId: product.id, onReturn: onReturn);
        },
        child: Card(
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: const Color(0xFFF8F9FE),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(
                    product.images[0],
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Image.asset("assets/images/placeholder.png");
                    },
                  ),
                  Positioned(
                    top: 5,
                    right: 7.5,
                    child: BlocBuilder<FavouriteBloc, FavouriteState>(
                      builder: (context, state) {
                        bool isFavourite = false;
                        if (state is FavouriteUpdated) {
                          isFavourite = state.items.contains(product);
                        }

                        return IconButton(
                          onPressed: () {
                            final favBloc = getIt<FavouriteBloc>();
                            if (isFavourite) {
                              favBloc.add(
                                RemoveFromFavourite(product: product),
                              );
                            } else {
                              favBloc.add(AddToFavourite(product: product));
                            }
                          },
                          icon: Icon(
                            isFavourite
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: const Color(0xFF0019FF),
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelWidget(
                      label: product.title,
                      widget: Text(
                        "€ ${product.price}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1F2024),
                        ),
                      ),
                      labelFontSize: 12,
                      labelColor: const Color(0xFF1F2024),
                      labelFontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 16),
                    AddToCartQuantity(
                      buttonBackgroundColor: Colors.white,
                      buttonContent: const Text(
                        "Add to cart",
                        style: TextStyle(
                          color: Color(0xFF0019FF),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      product: product,
                      buttonHeight: 36,
                      counterHeight: 36,
                      fontSize: 12,
                      buttonBorderColor: const Color(0xFF0019FF),
                      buttonBorderWidth: 1.5,
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
