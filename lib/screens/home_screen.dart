import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/featured_banner.dart';
import '../widgets/category_list.dart';
import '../widgets/product_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Product> products = [
    Product(
      "assets/images/product_one.jpg",
      "Trek Domane SL 7",
      8499,
      "Matte Deep Smoke",
      "A high-performance road bike with Shimano Di2 electronic shifting and a lightweight carbon frame.",
    ),
    Product(
      "assets/images/product_two.jpg",
      "Specialized Turbo",
      3999,
      "Silver/Black",
      "An electric hybrid bike ideal for commuting with a smooth and powerful motor-assisted ride.",
    ),
    Product(
      "assets/images/product_three.jpg",
      "Giant Talon 1",
      999,
      "White",
      "A versatile hardtail mountain bike with a lightweight aluminum frame and front suspension.",
    ),
    Product(
      "assets/images/product_four.jpg",
      "Cannondale Trail 5",
      1199,
      "Matte Black",
      "A solid mountain bike with modern geometry, 1x drivetrain, and durable components for off-road adventures.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.deepOrange,
        title: const Text("E-commerce", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Featured",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            const FeaturedBanner(),
            const SizedBox(height: 30),
            const Text(
              "Categories",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const CategoryList(),
            const SizedBox(height: 20),
            const Text(
              "All Products",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: (120 * products.length).toDouble(),
              child: ProductGrid(products: products),
            ),
          ],
        ),
      ),
    );
  }
}
