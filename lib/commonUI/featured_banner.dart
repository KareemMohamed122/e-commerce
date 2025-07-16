import 'package:flutter/material.dart' hide CarouselController;
import 'package:carousel_slider_plus/carousel_slider_plus.dart';

class FeaturedBanner extends StatefulWidget {
  final List<String> imgList;
  final double height;

  const FeaturedBanner({
    super.key,
    required this.imgList,
    required this.height,
  });

  @override
  State<FeaturedBanner> createState() => _FeaturedBannerState();
}

class _FeaturedBannerState extends State<FeaturedBanner> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: CarouselSlider(
            options: CarouselOptions(
              height: widget.height,
              viewportFraction: 1,
              onPageChanged: (index, _) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            items:
                widget.imgList.map((path) {
                  return Image.network(
                    path,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: widget.height,
                  );
                }).toList(),
          ),
        ),
        Positioned(
          bottom: 13,
          right: 167,
          child: SizedBox(
            width: 40,
            height: 8,
            child: Row(
              children: [
                buildDot(0),
                SizedBox(width: 8),
                buildDot(1),
                SizedBox(width: 8),
                buildDot(2),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container buildDot(int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        color:
            (currentIndex == index
                ? Color(0xFF0019FF)
                : Color(0xFF1F2024).withValues(alpha: 0.5)),
      ),
      width: 8,
      height: 8,
    );
  }
}
