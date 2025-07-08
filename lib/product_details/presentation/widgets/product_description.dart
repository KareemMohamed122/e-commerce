import 'package:flutter/material.dart';
import 'package:untitled2/commonUI/label_widget.dart';

class ProductDescription extends StatelessWidget {
  final String description;

  const ProductDescription({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return LabelWidget(
      label: "Details",
      widget: Text(description, style: TextStyle(fontSize: 18)),
    );
  }
}
