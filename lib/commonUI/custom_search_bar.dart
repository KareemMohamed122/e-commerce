import 'package:flutter/material.dart';
import 'package:untitled2/search_results_screen/presentation/screens/search_results_screen.dart';

class CustomSearchBar extends StatefulWidget {
  final List<String> recentWords;
  final ValueChanged<String> handleSubmit;
  final bool filterByCategory;
  final int? categoryID;
  const CustomSearchBar({
    super.key,
    required this.recentWords,
    required this.handleSubmit,
    required this.filterByCategory,
    this.categoryID,
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
        // _controller.clear();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) {
              return SearchResultsScreen(
                title: _controller.text,
                filterByCategory: widget.filterByCategory,
                categoryID: widget.categoryID,
                recentWords: [],
              );
            },
          ),
        );
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
