import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:untitled2/commonUI/cart_icon.dart';
import 'package:untitled2/commonUI/custom_appbar.dart';
import 'package:untitled2/models/product.dart';
import '../../../bloc/cart/cart_bloc.dart';
import '../../../bloc/cart/cart_event.dart';
import '../../../bloc/cart/cart_state.dart';
import '../../../commonUI/add_to_cart_quantity.dart';
import '../../../commonUI/label_widget.dart';
import '../../../core/injection.dart';
import '../widgets/product_image_card.dart';
import '../widgets/product_price_quantity.dart';
import '../widgets/product_description.dart';
import '../widgets/product_total_price.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Get.arguments as Product;
    final cartBloc = getIt<CartBloc>();
    return Scaffold(
      appBar: CustomAppbar(title: "Product Details", actions: [CartIcon()]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<CartBloc, CartState>(
          bloc: cartBloc,
          builder: (context, state) {
            final cart = cartBloc.getItems;
            final quantity = cart[product] ?? 0;
            final totalPrice = cartBloc.getProductTotal(product);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                LabelWidget(
                  label: product.productName ?? '',
                  widget: Text(
                    product.color ?? '',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 8),
                ProductImageCard(imagePath: product.img ?? ''),
                const SizedBox(height: 8),
                ProductPriceQuantity(
                  price: product.price ?? 0.0,
                  quantity: quantity,
                  onAdd: () {
                    CartBloc().add(AddToCart(product));
                  },
                  onRemove: () {
                    CartBloc().add(RemoveFromCart(product));
                  },
                ),
                const SizedBox(height: 8),
                ProductDescription(description: product.details ?? ''),
                const SizedBox(height: 8),
                ProductTotalPrice(totalPrice: totalPrice),
                const SizedBox(height: 8),
                AddToCartQuantity(
                  fontSize: 16,
                  product: product,
                  buttonWidth: 200,
                  buttonHeight: 50,
                  counterWidth: 200,
                  counterHeight: 50,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
