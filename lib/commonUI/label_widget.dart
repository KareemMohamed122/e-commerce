import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  final String label;
  final Widget widget;
  final Color labelColor;
  final double labelFontSize;
  final FontWeight labelFontWeight;
  final double gap;
  const LabelWidget({
    super.key,
    required this.label,
    required this.widget,
    required this.labelColor,
    required this.labelFontSize,
    required this.labelFontWeight,
    this.gap = 4,
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
            fontWeight: labelFontWeight,
            fontSize: labelFontSize,
            color: labelColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: gap),
        widget,
      ],
    );
  }
}
