import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:untitled2/bloc/product/product_bloc.dart';
import 'package:untitled2/bloc/product/product_event.dart';
import 'package:untitled2/bloc/category/category_bloc.dart';
import 'package:untitled2/bloc/category/category_event.dart';
import 'package:untitled2/bloc/category/category_state.dart';
import 'package:untitled2/core/injection.dart';
import 'package:untitled2/data/models/category.dart';
import 'package:untitled2/commonUI/custom_appbar.dart';
import 'package:untitled2/search_results_screen/presentation/screens/search_results_screen.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<CategoryModel> categories = [];
  bool isCategorySelected = false;
  String selectedSlug = "";
  double _minPrice = 0;
  double _maxPrice = 1000;

  final categoryBloc = getIt<CategoryBloc>();
  final productBloc = getIt<ProductBloc>();

  @override
  void initState() {
    super.initState();
    categoryBloc.add(LoadCategories());
  }

  void _clearAllFilters() {
    setState(() {
      isCategorySelected = false;
      selectedSlug = "";
      _minPrice = 0;
      _maxPrice = 1000;
    });
  }

  int _activeFiltersCount() {
    int count = 0;
    if (isCategorySelected) count++;
    if (_minPrice > 0 || _maxPrice < 1000) count++;
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: categoryBloc),
        BlocProvider.value(value: productBloc),
      ],
      child: Scaffold(
        appBar: CustomAppbar(
          height: 56,
          leading: TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              "Cancel",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0019FF),
              ),
            ),
          ),
          title: const Text(
            "Filter",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Color(0xFF1F2024),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Center(
                child: TextButton(
                  onPressed: _clearAllFilters,
                  child: const Text(
                    "Clear All",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0019FF),
                    ),
                  ),
                ),
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
                      trailing:
                          _activeFiltersCount() > 0
                              ? Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0019FF),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    "${_activeFiltersCount()}",
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                              : null,
                      title: const Text(
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
                                categories.map((category) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (selectedSlug == category.slug) {
                                          isCategorySelected = false;
                                          selectedSlug = "";
                                        } else {
                                          isCategorySelected = true;
                                          selectedSlug = category.slug;
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color:
                                            selectedSlug == category.slug
                                                ? const Color(0xFF0019FF)
                                                : const Color(0xFFE5E8FF),
                                      ),
                                      child: Text(
                                        category.slug,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              selectedSlug == category.slug
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
                    const Divider(thickness: 0.5, color: Color(0xFFD4D6DD)),
                    ExpansionTile(
                      title: const Text(
                        "Price Range",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF1F2024),
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Min: ${_minPrice.toInt()} EGP'),
                                  Text('Max: ${_maxPrice.toInt()} EGP'),
                                ],
                              ),
                              const SizedBox(height: 8),
                              RangeSlider(
                                min: 0,
                                max: 1000,
                                divisions: 100,
                                values: RangeValues(_minPrice, _maxPrice),
                                onChanged: (values) {
                                  setState(() {
                                    _minPrice = values.start;
                                    _maxPrice = values.end;
                                  });
                                },
                                activeColor: const Color(0xFF0019FF),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
              onPressed: () {
                productBloc.add(
                  UpdateProductFilters(
                    categorySlug: isCategorySelected ? selectedSlug : null,
                    minPrice: _minPrice,
                    maxPrice: _maxPrice,
                  ),
                );
                Get.to(() => const SearchResultsScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0019FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
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
      ),
    );
  }
}
