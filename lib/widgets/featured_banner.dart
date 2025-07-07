import 'package:flutter/material.dart';

class FeaturedBanner extends StatelessWidget {
  const FeaturedBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          SizedBox(
            width: 400,
            height: 200,
            child: Image.asset("assets/images/bike.jpg", fit: BoxFit.cover),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 400,
              height: 80,
              color: Colors.grey.withValues(alpha: 0.8),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Electric Bike",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "A smart eco-friendly ride",
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall!.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
