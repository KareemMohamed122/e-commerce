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
        IconButton(
          onPressed: onRemove,
          icon: const Icon(Icons.remove),
          padding: EdgeInsets.all(0),
          constraints: const BoxConstraints(),
        ),
        Container(
          alignment: Alignment.center,
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
          child: Text(
            quantity.toString(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
          onPressed: onAdd,
          icon: const Icon(Icons.add),
          padding: EdgeInsets.all(0),
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}
