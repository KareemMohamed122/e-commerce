import 'package:flutter/material.dart';

import '../../../bloc/cart/cart_bloc.dart';
import '../../../bloc/cart/cart_event.dart';
import '../../../commonUI/label_widget.dart';
import '../../../commonUI/quantity_widget.dart';
import '../../../core/injection.dart';

class CartProducts extends StatelessWidget {
  const CartProducts({super.key, required this.items});

  final Map items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, index) {
        final product = items.keys.toList()[index];
        final quantity = items[product] ?? 0;
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: Colors.white)],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Positioned(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      product.img ?? "",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 120,
                  child: LabelWidget(
                    label: "${product.productName}",
                    widget: Text("${product.color}"),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 120,
                  child: LabelWidget(
                    label: "Price",
                    widget: Text("\$${product.price}"),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 5,
                  child: QuantityWidget(
                    quantity: quantity,
                    onRemove: () {
                      getIt<CartBloc>().add(RemoveFromCart(product));
                    },
                    onAdd: () {
                      getIt<CartBloc>().add(AddToCart(product));
                    },
                    width: 24,
                    height: 24,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
