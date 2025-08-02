import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/product_details_navigation.dart';
import '../data/models/product.dart';
import 'add_to_cart_quantity.dart';
import 'label_widget.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback onReturn;

  const ProductCard({super.key, required this.product, required this.onReturn});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool favourite = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 241,
      child: InkWell(
        onTap: () {
          openProductDetails(
            productId: widget.product.id,
            onReturn: widget.onReturn,
          );
        },
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
              Stack(
                children: [
                  Image.network(
                    widget.product.images[0],
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Image.asset("assets/images/placeholder.png");
                    },
                  ),
                  Positioned(
                    top: 12,
                    right: 7.5,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          widget.product.isFavourite =
                              !widget.product.isFavourite;
                        });
                      },
                      icon: Icon(
                        widget.product.isFavourite
                            ? Icons.favorite
                            : Icons.favorite_outline,
                        color: const Color(0xFF0019FF),
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelWidget(
                      label: widget.product.title,
                      widget: Text(
                        "€ ${widget.product.price}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1F2024),
                        ),
                      ),
                      labelFontSize: 12,
                      labelColor: const Color(0xFF1F2024),
                      labelFontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: 16),
                    AddToCartQuantity(
                      buttonBackgroundColor: Colors.white,
                      buttonContent: Text(
                        "Add to cart",
                        style: TextStyle(
                          color: Color(0xFF0019FF),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      product: widget.product,
                      buttonHeight: 36,
                      counterHeight: 36,
                      fontSize: 12,
                      buttonBorderColor: Color(0xFF0019FF),
                      buttonBorderWidth: 1.5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
