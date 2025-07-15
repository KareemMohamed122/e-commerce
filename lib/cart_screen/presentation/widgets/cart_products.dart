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
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, index) {
        final product = items.keys.toList()[index];
        final quantity = items[product] ?? 0;

        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Dismissible(
            key: ValueKey(product.id),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              color: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (_) {
              getIt<CartBloc>().add(RemoveAllFromCart(product));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.title} removed from cart'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.white.withValues(alpha: 0.1)),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  children: [
                    Positioned(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          product.images[0] ?? "",
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
                        label: "${product.title}",
                        labelColor: Colors.black,
                        widget: Text("${product.categoryName}"),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 120,
                      child: LabelWidget(
                        label: "Price",
                        labelColor: Colors.black,
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
            ),
          ),
        );
      },
    );
  }
}
