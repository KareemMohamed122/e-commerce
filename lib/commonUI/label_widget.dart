import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  final String label;
  final Widget widget;
  final Color labelColor;
  const LabelWidget({
    super.key,
    required this.label,
    required this.widget,
    required this.labelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: labelColor,
          ),
        ),
        const SizedBox(height: 4),
        widget,
      ],
    );
  }
}
