import 'package:flutter/material.dart';
import 'package:untitled2/models/product.dart';
import '../widgets/add_to_cart.dart';
import '../widgets/product_image_card.dart';
import '../widgets/product_price_quantity.dart';
import '../widgets/product_description.dart';
import '../widgets/product_total_price.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: Text(
          "Product Details",
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              product.productName!,
              style: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(color: Colors.black),
            ),
            const SizedBox(height: 5),
            Text(
              product.color!,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 15),
            ProductImageCard(imagePath: product.img!),
            const SizedBox(height: 15),
            ProductPriceQuantity(
              price: product.price!,
              counter: counter,
              onAdd: () {
                setState(() => counter++);
              },
              onRemove: () {
                if (counter > 0) setState(() => counter--);
              },
            ),
            const SizedBox(height: 10),
            ProductDescription(description: product.details!),
            const SizedBox(height: 10),
            ProductTotalPrice(price: product.price!, quantity: counter),
            const SizedBox(height: 15),
            const Center(child: AddToCartButton()),
          ],
        ),
      ),
    );
  }
}
