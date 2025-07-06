import 'package:flutter/material.dart';

class ProductPriceQuantity extends StatelessWidget {
  final int price;
  final int counter;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const ProductPriceQuantity({
    super.key,
    required this.price,
    required this.counter,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "PRICE",
              style: Theme.of(
                context,
              ).textTheme.labelMedium!.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 3),
            Text(
              "\$$price",
              style: Theme.of(
                context,
              ).textTheme.headlineMedium!.copyWith(color: Colors.deepOrange),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Text(
                "QUANTITY",
                style: Theme.of(
                  context,
                ).textTheme.labelMedium!.copyWith(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(onPressed: onRemove, icon: const Icon(Icons.remove)),
                Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Text(counter.toString()),
                ),
                IconButton(onPressed: onAdd, icon: const Icon(Icons.add)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
