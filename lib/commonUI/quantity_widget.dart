import 'package:flutter/material.dart';

class QuantityWidget extends StatelessWidget {
  const QuantityWidget({
    super.key,
    required this.quantity,
    required this.onRemove,
    required this.onAdd,
    required this.width,
    required this.height,
  });

  final int quantity;
  final VoidCallback onRemove;
  final VoidCallback onAdd;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 32,
          height: 32,
          child: IconButton(
            onPressed: onRemove,
            icon: const Icon(Icons.remove, size: 18),
            padding: EdgeInsets.zero,
          ),
        ),

        Container(
          alignment: Alignment.center,
          width: width,
          height: height,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
          child: Text(
            '$quantity',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(
          width: 32,
          height: 32,
          child: IconButton(
            onPressed: onAdd,
            icon: const Icon(Icons.add, size: 18),
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }
}
