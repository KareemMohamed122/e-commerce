import 'dart:ui';

import 'package:get/get.dart';

import '../../presentation/product_details/presentation/screens/product_details.dart';

Future<void> openProductDetails({
  required int productId,
  required VoidCallback onReturn,
}) async {
  await Get.to(() => const ProductDetails(), arguments: productId);
  onReturn();
}
