import 'package:get/get.dart';
import 'package:untitled2/models/product.dart';

class ProductDetailsController extends GetxController {
  Rx<int> counter = 0.obs;
  Rx<bool> isLoading = true.obs;
  late Product product;
  void showProduct(Product myProduct) async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2));
    product = myProduct;
    isLoading.value = false;
  }

  void increase() => counter.value++;
  void decrease() {
    if (counter.value > 0) {
      counter.value--;
    }
  }

  double calculateTotalPrice(int quantity) {
    return quantity * (product.price ?? 0.0);
  }
}
