import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled2/bloc/cart/cart_bloc.dart';
import 'package:untitled2/cart_screen/presentation/widgets/cart_products.dart';
import 'package:untitled2/commonUI/custom_appbar.dart';
import 'package:untitled2/commonUI/label_widget.dart';
import 'package:untitled2/commonUI/quantity_widget.dart';
import '../../../bloc/cart/cart_event.dart';
import '../../../bloc/cart/cart_state.dart';
import '../../../core/injection.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Shopping Cart",
        actions: [
          IconButton(
            onPressed: () {
              getIt<CartBloc>().add(ClearCart());
            },
            icon: Icon(Icons.delete, color: Colors.white),
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        bloc: getIt<CartBloc>(),
        builder: (context, state) {
          final items = (state is CartUpdated) ? state.items : {};
          final products = items.keys.toList();
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
                        Expanded(
                          child: CartProducts(items: items, products: products),
                        ),
                        totalCheckout(total),
                      ],
                    ),
          );
        },
      ),
    );
  }

  Row totalCheckout(double total) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          "Total:",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            "\$$total",
            style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 18),
          ),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrange,
            fixedSize: const Size(200, 50),
          ),
          onPressed: () {
            // Checkout Action
          },
          child: const Text(
            "Check Out",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
