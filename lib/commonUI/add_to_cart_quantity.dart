import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/commonUI/quantity_widget.dart';

import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_event.dart';
import '../bloc/cart/cart_state.dart';
import '../core/injection.dart'; // لازم تتأكد إن فيه getIt<CartBloc>() هناك
import '../models/product.dart';
import 'add_to_cart.dart';

class AddToCartQuantity extends StatelessWidget {
  const AddToCartQuantity({
    super.key,
    required this.quantity,
    required this.product,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.counterWidth,
    required this.counterHeight,
    required this.fontSize,
  });

  final int quantity;
  final Product product;
  final double buttonWidth;
  final double buttonHeight;
  final double counterWidth;
  final double counterHeight;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final cartBloc = getIt<CartBloc>();

    return BlocBuilder<CartBloc, CartState>(
      bloc: cartBloc,
      builder: (_, state) {
        if (state is CartInitial || quantity == 0) {
          return Center(
            child: AddToCartButton(
              fontSize: fontSize,
              width: buttonWidth,
              height: buttonHeight,
              product: product,
            ),
          );
        } else {
          return Center(
            child: QuantityWidget(
              quantity: quantity,
              onRemove: () {
                cartBloc.add(RemoveFromCart(product));
              },
              onAdd: () {
                cartBloc.add(AddToCart(product));
              },
              width: counterWidth,
              height: counterHeight,
            ),
          );
        }
      },
    );
  }
}
