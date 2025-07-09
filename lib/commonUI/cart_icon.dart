import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled2/cart_screen/presentation/screens/cart_screen.dart';

import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_state.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final bloc = context.read<CartBloc>();
        final total = bloc.totalQuantity;
        return Stack(
          children: [
            IconButton(
              onPressed: () {
                Get.to(() => CartScreen());
              },
              icon: Icon(Icons.shopping_cart),
              color: Colors.white,
              iconSize: 30,
            ),
            Positioned(
              right: 1,
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.black,
                ),
                child: Center(
                  child: Text(
                    "$total",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
