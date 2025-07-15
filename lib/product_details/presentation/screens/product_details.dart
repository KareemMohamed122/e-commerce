import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:untitled2/commonUI/cart_icon.dart';
import 'package:untitled2/commonUI/custom_appbar.dart';
import '../../../bloc/cart/cart_bloc.dart';
import '../../../bloc/cart/cart_event.dart';
import '../../../bloc/cart/cart_state.dart';
import '../../../commonUI/add_to_cart_quantity.dart';
import '../../../commonUI/label_widget.dart';
import '../../../commonUI/navigation_bar.dart';
import '../../../core/injection.dart';
import '../../../data/models/product.dart';
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
      appBar: CustomAppbar(
        leading: const Icon(Icons.search_outlined),
        title: Image.asset("assets/images/home_images/casaforsa.png"),
        actions: const [Icon(Icons.favorite), Icon(Icons.shopping_bag)],
      ),
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
                  label: product.title ?? '',
                  labelColor: Colors.black,
                  widget: Text(
                    product.categoryName ?? '',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 8),
                ProductImageCard(imagePath: product.images[0] ?? ''),
                const SizedBox(height: 8),
                ProductPriceQuantity(
                  price: product.price.toDouble() ?? 0.0,
                  quantity: quantity,
                  onAdd: () {
                    CartBloc().add(AddToCart(product));
                  },
                  onRemove: () {
                    CartBloc().add(RemoveFromCart(product));
                  },
                ),
                const SizedBox(height: 8),
                ProductDescription(description: product.description ?? ''),
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
