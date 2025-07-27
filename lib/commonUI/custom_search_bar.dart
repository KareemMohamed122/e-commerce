import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final List<String> recentWords;
  final ValueChanged<String> handleSubmit;

  const CustomSearchBar({
    super.key,
    required this.recentWords,
    required this.handleSubmit,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      cursorColor: const Color(0xFF0019FF),
      onSubmitted: (value) {
        widget.handleSubmit(value.trim());
        _controller.clear();
      },
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: Color(0xFF1F2024),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF8F9FE),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
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
        prefixIcon: const Icon(
          Icons.search_outlined,
          size: 16,
          color: Color(0xFF2F3036),
        ),
      ),
    );
  }
}
