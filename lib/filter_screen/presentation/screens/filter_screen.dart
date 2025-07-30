import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled2/commonUI/custom_appbar.dart';
import 'package:untitled2/data/models/category.dart';

import '../../../bloc/category/category_bloc.dart';
import '../../../bloc/category/category_event.dart';
import '../../../bloc/category/category_state.dart';
import '../../../core/injection.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  @override
  void initState() {
    super.initState();
    getIt<CategoryBloc>().add(LoadCategories());
  }

  List<CategoryModel> categories = [];
  bool isCategorySelected = false;
  String selectedItem = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        height: 56,
        leading: TextButton(
          child: Text(
            "Cancel",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0019FF),
            ),
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Filter",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: Color(0xFF1F2024),
          ),
        ),
        actions: [
          Text(
            "Clear All",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0019FF),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: SingleChildScrollView(
          child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoriesLoaded) {
                categories = state.categories;
              }
              return Column(
                children: [
                  ExpansionTile(
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    expandedAlignment: Alignment.topLeft,
                    trailing:
                        isCategorySelected
                            ? Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: const Color(0xFF0019FF),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Text(
                                  "1",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                            : null,
                    shape: Border(),
                    title: Text(
                      "Category",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF1F2024),
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children:
                              categories.map((CategoryModel category) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (selectedItem == category.name) {
                                        isCategorySelected = false;
                                        selectedItem = "";
                                      } else {
                                        selectedItem = category.name;
                                        isCategorySelected = true;
                                      }
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color:
                                          selectedItem == category.name
                                              ? const Color(0xFF0019FF)
                                              : const Color(0xFFE5E8FF),
                                    ),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      category.name,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            selectedItem == category.name
                                                ? Colors.white
                                                : const Color(0xFF0019FF),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                    ],
                  ),

                  Divider(thickness: 0.5, color: Color(0xFFD4D6DD)),
                  SizedBox(
                    height: 56,
                    child: ExpansionTile(
                      shape: Border(),
                      title: Text(
                        "Price Range",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF1F2024),
                        ),
                      ),
                    ),
                  ),
                  Divider(thickness: 0.5, color: Color(0xFFD4D6DD)),
                  SizedBox(
                    height: 56,
                    child: ExpansionTile(
                      shape: Border(),
                      title: Text(
                        "Color",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF1F2024),
                        ),
                      ),
                    ),
                  ),
                  Divider(thickness: 0.5, color: Color(0xFFD4D6DD)),

                  SizedBox(
                    height: 56,
                    child: ExpansionTile(
                      shape: Border(),
                      title: Text(
                        "Size",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF1F2024),
                        ),
                      ),
                    ),
                  ),
                  Divider(thickness: 0.5, color: Color(0xFFD4D6DD)),

                  SizedBox(
                    height: 56,
                    child: ExpansionTile(
                      shape: Border(),
                      title: Text(
                        "Customer View",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF1F2024),
                        ),
                      ),
                    ),
                  ),
                  Divider(thickness: 0.5, color: Color(0xFFD4D6DD)),

                  // SizedBox(height: 24),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: SizedBox(
          height: 48,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF0019FF),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "Apply Filters",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
