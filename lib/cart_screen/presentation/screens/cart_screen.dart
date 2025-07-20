import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled2/bloc/cart/cart_bloc.dart';
import 'package:untitled2/cart_screen/presentation/widgets/cart_products.dart';
import 'package:untitled2/commonUI/custom_appbar.dart';
import '../../../bloc/cart/cart_state.dart';
import '../../../core/injection.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        height: 56,
        leading: IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF0019FF), size: 20),
        ),
        title: Text(
          'Your bag',
          style: TextStyle(
            color: Color(0xFF1F2024),
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        actions: [],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        bloc: getIt<CartBloc>(),
        builder: (context, state) {
          final items = getIt<CartBloc>().getItems;
          final total = getIt<CartBloc>().totalPrice;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                items.isEmpty
                    ? Center(
                      child: Lottie.asset("assets/images/emptycart.json"),
                    )
                    : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: CartProducts(items: items)),
                        totalCheckout(total),
                      ],
                    ),
          );
        },
      ),
    );
  }

  Widget totalCheckout(double total) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xFF71727A),
              ),
            ),
            Text(
              "€ $total",
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: Color(0xFF1F2024),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF0019FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {},
            child: const Text(
              "Checkout",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
