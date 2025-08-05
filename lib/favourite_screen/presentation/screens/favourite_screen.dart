import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled2/bloc/favourite/favourite_bloc.dart';
import 'package:untitled2/bloc/favourite/favourite_event.dart';
import 'package:untitled2/bloc/favourite/favourite_state.dart';
import 'package:untitled2/commonUI/custom_appbar.dart';
import 'package:untitled2/favourite_screen/presentation/widgets/favourite_products.dart';
import '../../../core/injection.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  // @override
  // void initState() {
  //   getIt<FavouriteBloc>().add(LoadFavourite());
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        height: 56,
        leading: IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF0019FF),
            size: 20,
          ),
        ),
        title: const Text(
          'Your Favourites',
          style: TextStyle(
            color: Color(0xFF1F2024),
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ),
      body: BlocBuilder<FavouriteBloc, FavouriteState>(
        bloc: getIt<FavouriteBloc>(),
        builder: (context, state) {
          final items = getIt<FavouriteBloc>().favourite;

          if (items.isEmpty) {
            return Center(child: Lottie.asset("assets/images/emptycart.json"));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: FavouriteProducts(items: items),
          );
        },
      ),
    );
  }
}
