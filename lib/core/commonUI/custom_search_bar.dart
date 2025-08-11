import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../bloc/product/product_bloc.dart';
import '../bloc/product/product_event.dart';

class CustomSearchBar extends StatefulWidget {
  final List<String> recentWords;
  final ValueChanged<String> handleSubmit;
  final bool filterByCategory;
  final int? categoryID;
  final String? hintText;

  const CustomSearchBar({
    super.key,
    required this.recentWords,
    required this.handleSubmit,
    required this.filterByCategory,
    this.categoryID,
    this.hintText,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.recentWords.isNotEmpty ? widget.recentWords.last : '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      cursorColor: const Color(0xFF0019FF),
      onSubmitted: (value) {
        final trimmedValue = value.trim();
        if (trimmedValue.isNotEmpty) {
          widget.handleSubmit(trimmedValue);
          context.read<ProductBloc>().add(
            UpdateProductFilters(
              searchText: trimmedValue,
              categoryId:
                  widget.filterByCategory && widget.categoryID != null
                      ? widget.categoryID
                      : null,
            ),
          );
          _controller.clear();
        }
      },
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: Color(0xFF1F2024),
      ),
      decoration: InputDecoration(
        hintText: widget.hintText ?? 'Search',
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
