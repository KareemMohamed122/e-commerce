import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Color(0xFF0019FF),
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: Color(0xFF1F2024),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFF8F9FE),
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(
          Icons.search_outlined,
          size: 16,
          color: Color(0xFF2F3036),
        ),
      ),
    );
  }
}
