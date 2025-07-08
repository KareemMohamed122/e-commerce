import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled2/models/product.dart';
import '../../../commonUI/label_widget.dart';
import '../manager/product_details_controller.dart';
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
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: Text(
          "Product Details",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
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
              const SizedBox(height: 8),
              LabelWidget(
                label: "${product.productName}",
                widget: Text(
                  "${product.color}",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 8),
              ProductImageCard(imagePath: product.img!),
              const SizedBox(height: 8),
              ProductPriceQuantity(
                price: product.price ?? 0.0,
                onAdd: () {
                  controller.increase();
                },
                onRemove: () {
                  controller.decrease();
                },
              ),
              const SizedBox(height: 8),
              ProductDescription(description: product.details!),
              const SizedBox(height: 8),
              ProductTotalPrice(
                totalPrice: controller.calculateTotalPrice(
                  (controller.counter.value ?? 0),
                ),
              ),
              const SizedBox(height: 8),
              const Center(child: AddToCartButton()),
            ],
          );
        }),
      ),
    );
  }
}
