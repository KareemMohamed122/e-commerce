import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:untitled2/bloc/favourite/favourite_bloc.dart';
import 'package:untitled2/bloc/favourite/favourite_event.dart';
import 'package:untitled2/bloc/favourite/favourite_state.dart';
import 'package:untitled2/bloc/product/product_event.dart';
import 'package:untitled2/commonUI/featured_banner.dart';
import '../../../bloc/cart/cart_bloc.dart';
import '../../../bloc/cart/cart_state.dart';
import '../../../bloc/product/product_bloc.dart';
import '../../../bloc/product/product_state.dart';
import '../../../core/injection.dart';
import '../../../commonUI/add_to_cart_quantity.dart';
import '../../../commonUI/label_widget.dart';
import 'package:untitled2/data/models/product.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = Get.arguments as int;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProductBloc(getIt())..add(LoadProduct(productId)),
        ),
        BlocProvider.value(value: getIt<FavouriteBloc>()),
      ],
      child: const _ProductDetailsBody(),
    );
  }
}

class _ProductDetailsBody extends StatefulWidget {
  const _ProductDetailsBody({super.key});

  @override
  State<_ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<_ProductDetailsBody> {
  final cartBloc = getIt<CartBloc>();

  int selectedIndex = 0;
  int selectedColorIndex = 0;

  final List<String> sizes = ["160×120", "180×200", "200×200", "220×220"];
  final List<Color> colors = [
    Color(0xFFB8C79C),
    Color(0xFF9CA4E9),
    Color(0xFFE8BFF2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            final product = state.product;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildHeader(product),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildHeadLine(product),
                        const SizedBox(height: 24),
                        Text(
                          product.description,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF71727A),
                          ),
                        ),
                        const SizedBox(height: 40),
                        buildSizeSelector(),
                        const SizedBox(height: 32),
                        buildColorSelector(),
                        const SizedBox(height: 40),
                        BlocBuilder<CartBloc, CartState>(
                          builder: (context, state) {
                            return AddToCartQuantity(
                              buttonContent: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.add,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Add to cart",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              product: product,
                              buttonHeight: 48,
                              counterHeight: 48,
                              fontSize: 12,
                              buttonBackgroundColor: Color(0xFF0019FF),
                              buttonBorderWidth: 0,
                              buttonBorderColor: Color(0xFF0019FF),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  LabelWidget buildColorSelector() {
    return LabelWidget(
      label: "Color",
      gap: 8,
      labelFontSize: 12,
      labelFontWeight: FontWeight.w700,
      labelColor: Color(0xFF1F2024),
      widget: Row(
        children: List.generate(colors.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedColorIndex = index;
                });
              },
              child: buildColorContainer(
                colors[index],
                selectedColorIndex == index,
              ),
            ),
          );
        }),
      ),
    );
  }

  LabelWidget buildSizeSelector() {
    return LabelWidget(
      label: "Size",
      labelFontSize: 12,
      gap: 8,
      labelFontWeight: FontWeight.w700,
      labelColor: Color(0xFF1F2024),
      widget: Row(
        children: List.generate(sizes.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: buildSizeButton(sizes[index], selectedIndex == index, () {
              setState(() {
                selectedIndex = index;
              });
            }),
          );
        }),
      ),
    );
  }

  Row buildHeadLine(Product product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: LabelWidget(
            label: product.title,
            labelFontSize: 18,
            labelFontWeight: FontWeight.w800,
            labelColor: Color(0xFF1F2024),
            widget: Text(
              '€ ${product.price}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF1F2024),
              ),
            ),
          ),
        ),
        BlocBuilder<FavouriteBloc, FavouriteState>(
          builder: (context, favState) {
            bool isFavourite = false;

            if (favState is FavouriteUpdated) {
              isFavourite = favState.items.contains(product);
            }

            return IconButton(
              onPressed: () {
                if (isFavourite) {
                  getIt<FavouriteBloc>().add(
                    RemoveFromFavourite(product: product),
                  );
                } else {
                  getIt<FavouriteBloc>().add(AddToFavourite(product: product));
                }
              },
              icon: Icon(
                isFavourite ? Icons.favorite : Icons.favorite_outline,
                color: const Color(0xFF0019FF),
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            );
          },
        ),
      ],
    );
  }

  Stack buildHeader(Product product) {
    return Stack(
      children: [
        FeaturedBanner(imgList: product.images.take(3).toList(), height: 346),
        Positioned(
          top: 54,
          left: 24,
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.close, size: 20, color: Color(0xFF2F3036)),
          ),
        ),
      ],
    );
  }
}

// Size Button
Widget buildSizeButton(String label, bool isSelected, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      width: 72,
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? const Color(0xFF0019FF) : const Color(0xFFE5E8FF),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.white : const Color(0xFF0019FF),
        ),
      ),
    ),
  );
}

// Color Container
Widget buildColorContainer(Color color, bool isSelected) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      if (isSelected)
        Positioned(
          top: -4,
          left: 20,
          child: CircleAvatar(
            radius: 12,
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.check_circle,
              size: 16,
              color: Color(0xFF0019FF),
            ),
          ),
        ),
    ],
  );
}
