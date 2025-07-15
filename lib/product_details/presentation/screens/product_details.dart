import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:untitled2/commonUI/featured_banner.dart';
import '../../../bloc/cart/cart_bloc.dart';
import '../../../bloc/cart/cart_event.dart';
import '../../../bloc/cart/cart_state.dart';
import '../../../core/injection.dart';
import '../../../data/models/product.dart';
import '../widgets/product_price_quantity.dart';
import '../widgets/product_description.dart';
import '../widgets/product_total_price.dart';
import '../../../commonUI/add_to_cart_quantity.dart';
import '../../../commonUI/label_widget.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final product = Get.arguments as Product;
  final cartBloc = getIt<CartBloc>();

  bool favourite = false;
  int selectedIndex = 0;
  int selectedColorIndex = 0;

  final List<String> sizes = ["160×120", "180×200", "200×200", "220×220"];
  final List<Color> colors = [
    Color(0xFFB8C79C),
    Color(0xFF9CA4E9),
    Color(0xFFE8BFF2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartBloc, CartState>(
        bloc: cartBloc,
        builder: (context, state) {
          final cart = cartBloc.getItems;
          final quantity = cart[product] ?? 0;
          final totalPrice = cartBloc.getProductTotal(product);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    FeaturedBanner(
                      imgList:
                          product.images.isNotEmpty
                              ? product.images.take(3).toList()
                              : ['assets/images/placeholder.png'],
                      height: 345,
                    ),
                    Positioned(
                      top: 54,
                      left: 24,
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.close,
                          size: 20,
                          color: Color(0xFF2F3036),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabelWidget(
                            label: product.title,
                            labelFontSize: 18,
                            labelFontWeight: FontWeight.w800,
                            labelColor: Colors.black,
                            widget: Text(
                              '\$${product.price}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                favourite = !favourite;
                              });
                            },
                            icon: Icon(
                              favourite
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              color: const Color(0xFF0019FF),
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        product.description,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF71727A),
                        ),
                      ),
                      const SizedBox(height: 16),
                      LabelWidget(
                        label: "Size",
                        labelFontSize: 12,
                        labelFontWeight: FontWeight.w600,
                        labelColor: Colors.black,
                        widget: Row(
                          children: List.generate(sizes.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: buildSizeButton(
                                sizes[index],
                                selectedIndex == index,
                                () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 16),
                      LabelWidget(
                        label: "Color",
                        labelFontSize: 12,
                        labelFontWeight: FontWeight.w600,
                        labelColor: Colors.black,
                        widget: Row(
                          children: List.generate(colors.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedColorIndex = index;
                                  });
                                },
                                child: buildColorContainer(
                                  colors[index],
                                  selectedColorIndex == index,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 16),
                      AddToCartQuantity(
                        fontSize: 16,
                        product: product,
                        buttonWidth: 200,
                        buttonHeight: 50,
                        counterWidth: 200,
                        counterHeight: 50,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget buildSizeButton(String label, bool isSelected, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      width: 72,
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? const Color(0xFF0019FF) : const Color(0xFFE5E8FF),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.white : const Color(0xFF0019FF),
        ),
      ),
    ),
  );
}

Widget buildColorContainer(Color color, bool isSelected) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      if (isSelected)
        Positioned(
          top: -4,
          left: 20,
          child: CircleAvatar(
            radius: 10,
            backgroundColor: Colors.white,
            child: Icon(Icons.check_circle, size: 16, color: Color(0xFF0019FF)),
          ),
        ),
    ],
  );
}
