import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:untitled2/bloc/cart/cart_bloc.dart';
import 'package:untitled2/bloc/cart/cart_state.dart';
import 'package:untitled2/commonUI/label_widget.dart';
import '../../../bloc/product/product_bloc.dart';
import '../../../bloc/product/product_event.dart';
import '../../../core/injection.dart' show getIt;
import '../../../core/product_details_navigation.dart';
import '../../../data/models/product.dart';
import '../../../product_details/presentation/screens/product_details.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;

  const ProductGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      bloc: getIt<CartBloc>(),
      builder: (context, state) {
        final cart = (state is CartUpdated) ? state.items : {};

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
            final quantity = cart[product];

            return InkWell(
              onTap: () {
                openProductDetails(
                  productId: product.id,
                  onReturn: () {
                    // getIt<ProductBloc>().add(LoadProducts());
                  },
                );
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
