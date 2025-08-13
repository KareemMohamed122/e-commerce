import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/core/commonUI/quantity_widget.dart';
import '../../domain/entity/product.dart';
import '../bloc/cart/cart_bloc.dart';
import '../bloc/cart/cart_event.dart';
import '../bloc/cart/cart_state.dart';
import '../../dependency_injection/injection.dart';
import 'add_to_cart.dart';

class AddToCartQuantity extends StatelessWidget {
  const AddToCartQuantity({
    super.key,
    required this.product,
    required this.buttonHeight,
    required this.counterHeight,
    required this.fontSize,
    required this.buttonContent,
    required this.buttonBackgroundColor,
    required this.buttonBorderColor,
    required this.buttonBorderWidth,
  });

  final Product product;
  final double buttonHeight;
  final double counterHeight;
  final double fontSize;
  final Widget buttonContent;
  final Color buttonBackgroundColor;
  final Color buttonBorderColor;
  final double buttonBorderWidth;

  @override
  Widget build(BuildContext context) {
    final cartBloc = getIt<CartBloc>();

    return BlocBuilder<CartBloc, CartState>(
      bloc: cartBloc,
      builder: (_, state) {
        int quantity = cartBloc.getItems[product] ?? 0;

        if (state is CartInitial || quantity == 0) {
          return Center(
            child: AddToCartButton(
              fontSize: fontSize,
              height: buttonHeight,
              product: product,
              buttonContent: buttonContent,
              buttonBackgroundColor: buttonBackgroundColor,
              buttonBorderWidth: buttonBorderWidth,
              buttonBorderColor: buttonBorderColor,
            ),
          );
        } else {
          return Center(
            child: QuantityWidget(
              quantity: quantity,
              onRemove: () {
                cartBloc.add(DecrementQuantity(product));
              },
              onAdd: () {
                cartBloc.add(IncrementQuantity(product));
              },
              height: counterHeight,
            ),
          );
        }
      },
    );
  }
}
