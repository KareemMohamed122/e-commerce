import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/bloc/cart/cart_bloc.dart';
import '../../../core/bloc/cart/cart_state.dart';
import '../../../core/commonUI/label_widget.dart';
import '../../../core/services/product_details_navigation.dart';
import '../../../core/services/injection.dart';
import '../../../data/models/product_dto.dart';
import '../../../domain/entity/product.dart';
import '../../../product_details/presentation/screens/product_details.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;

  const ProductGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      bloc: getIt<CartBloc>(),
      builder: (context, cartState) {
        final cart = (cartState is CartUpdated) ? cartState.items : {};

        return GridView.builder(
          shrinkWrap: true,
          itemCount: products.length,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            final product = products[index];

            return InkWell(
              onTap: () {
                openProductDetails(productId: product.id, onReturn: () {});
              },
              child: SizedBox(
                width: 200,
                height: 189,
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
                      Image.network(
                        product.images[0],
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) {
                          return Image.asset("assets/images/placeholder.png");
                        },
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
                              labelColor: Color(0xFF1F2024),
                              labelFontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
