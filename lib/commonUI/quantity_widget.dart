import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../product_details/presentation/manager/product_details_controller.dart';

class QuantityWidget extends StatelessWidget {
  const QuantityWidget({
    super.key,
    required this.onRemove,
    required this.onAdd,
  });

  final VoidCallback onRemove;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductDetailsController());

    return Row(
      children: [
        IconButton(
          onPressed: onRemove,
          icon: const Icon(Icons.remove),
          padding: EdgeInsets.all(0),
          constraints: const BoxConstraints(),
        ),
        Obx(
          () => Container(
            alignment: Alignment.center,
            width: 50,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: Text(controller.counter.value.toString()),
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
