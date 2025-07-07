import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled2/controllers/product_details_controller.dart';
import 'package:untitled2/models/product.dart';
import '../widgets/add_to_cart.dart';
import '../widgets/product_image_card.dart';
import '../widgets/product_price_quantity.dart';
import '../widgets/product_description.dart';
import '../widgets/product_total_price.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final controller = Get.put(ProductDetailsController());

  @override
  Widget build(BuildContext context) {
    final product = Get.arguments as Product;
    controller.showProduct(product);

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
        child: Obx(() {
          if (controller.isLoading.value) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(child: CircularProgressIndicator()),
            );
          }
          return Column(
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
                onAdd: () {
                  controller.increase();
                },
                onRemove: () {
                  controller.decrease();
                },
              ),
              const SizedBox(height: 10),
              ProductDescription(description: product.details!),
              const SizedBox(height: 10),
              ProductTotalPrice(
                price: product.price!,
                quantity: controller.counter.value,
              ),
              const SizedBox(height: 15),
              const Center(child: AddToCartButton()),
            ],
          );
        }),
      ),
    );
  }
}
