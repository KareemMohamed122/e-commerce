import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

import '../../presentation/cart_screen/presentation/screens/cart_screen.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_state.dart';
import '../services/injection.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final bloc = getIt<CartBloc>();
        final total = bloc.totalQuantity;

        return InkWell(
          onTap: () {
            Get.to(CartScreen());
          },
          child: badges.Badge(
            badgeContent: Text(
              "$total",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
            badgeStyle: badges.BadgeStyle(
              badgeColor: Color(0xFF0019FF),
              padding: EdgeInsets.all(4),
              borderRadius: BorderRadius.circular(20),
            ),
            position: badges.BadgePosition.bottomEnd(bottom: -10, end: -8),
            child: Icon(
              Icons.shopping_bag_outlined,
              color: Color(0xFF1F2024),
              size: 24,
            ),
          ),
        );
      },
    );
  }
}
