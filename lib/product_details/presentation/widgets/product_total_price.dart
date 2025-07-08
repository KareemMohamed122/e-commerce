import 'package:flutter/material.dart';
import 'package:untitled2/commonUI/label_widget.dart';

class ProductTotalPrice extends StatelessWidget {
  final double totalPrice;

  const ProductTotalPrice({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return LabelWidget(
      label: "Total Price",
      widget: Text("\$${totalPrice ?? 0.0}", style: TextStyle(fontSize: 18)),
    );
  }
}
