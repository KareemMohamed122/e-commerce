import 'package:flutter/material.dart';
import 'package:untitled2/bloc/cart/cart_bloc.dart';
import '../../../bloc/cart/cart_event.dart';
import '../../../commonUI/label_widget.dart';
import '../../../commonUI/quantity_widget.dart';
import '../../../core/injection.dart';
import '../../../data/models/product.dart';

class CartProducts extends StatelessWidget {
  const CartProducts({super.key, required this.items});

  final Map<Product, int> items;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      //padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemBuilder: (_, index) {
        final product = items.keys.toList()[index];
        final quantity = items[product] ?? 0;

        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
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
                        SizedBox(height: 9),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            QuantityWidget(
                              // height: 32,
                              // width: 75,
                              quantity: quantity,
                              onRemove: () {
                                getIt<CartBloc>().add(
                                  DecrementQuantity(product),
                                );
                              },
                              onAdd: () {
                                getIt<CartBloc>().add(
                                  IncrementQuantity(product),
                                );
                              },
                            ),
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (_, _) {
        return Divider(color: Color(0xFFD4D6DD));
      },
    );
  }
}
