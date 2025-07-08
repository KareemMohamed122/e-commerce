import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  final String label;
  final Widget widget;
  const LabelWidget({super.key, required this.label, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 4),
        widget,
      ],
    );
  }
}
