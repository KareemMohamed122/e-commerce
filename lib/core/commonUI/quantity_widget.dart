import 'package:flutter/material.dart';

class QuantityWidget extends StatelessWidget {
  const QuantityWidget({
    super.key,
    required this.quantity,
    required this.onRemove,
    required this.onAdd,
    this.height,
    this.width,
  });

  final int quantity;
  final VoidCallback onRemove;
  final VoidCallback onAdd;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Color(0xFFE5E8FF)),
          ),
          onPressed: onRemove,
          icon: const Icon(Icons.remove, size: 24, color: Color(0xFF0019FF)),
          padding: EdgeInsets.zero,
        ),
        SizedBox(width: 4),

        Text(
          '$quantity',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        SizedBox(width: 4),

        IconButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Color(0xFFE5E8FF)),
          ),
          onPressed: onAdd,
          icon: const Icon(Icons.add, size: 24, color: Color(0xFF0019FF)),
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}
