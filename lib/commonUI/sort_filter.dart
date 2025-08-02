import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:untitled2/bloc/product/product_bloc.dart';
import 'package:untitled2/bloc/product/product_event.dart';
import 'package:untitled2/core/injection.dart';
import 'package:untitled2/filter_screen/presentation/screens/filter_screen.dart';

class SortFilter extends StatefulWidget {
  const SortFilter({super.key});

  @override
  State<SortFilter> createState() => _SortFilterState();
}

class _SortFilterState extends State<SortFilter> {
  String? selectedSort;
  bool isLong = false;

  final List<String> sortOptions = [
    'Price:high to low',
    'Price:low to high',
    'Name: A to Z',
    'Name: Z to A',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [buildDropDownList(), buildFilter()],
      ),
    );
  }

  Container buildFilter() {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFC5C6CC)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: InkWell(
          onTap: () => Get.to(() => const FilterScreen()),
          child: Row(
            children: [
              SvgPicture.asset("assets/icons/sort.svg"),
              const SizedBox(width: 8),
              const Text(
                "Filter",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color(0xFF1F2024),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFF0019FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "2",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildDropDownList() {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFC5C6CC)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Row(
            children: [
              SvgPicture.asset("assets/icons/updown.svg"),
              const SizedBox(width: 8),
              const Text(
                'Sort',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF1F2024),
                ),
              ),
            ],
          ),
          value: selectedSort,
          items:
              sortOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/updown.svg"),
                      const SizedBox(width: 8),
                      Text(
                        value,
                        maxLines: 1,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF1F2024),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                selectedSort = newValue;
                isLong = true;
              });

              final bloc = getIt<ProductBloc>();
              bloc.add(SortProducts(newValue));
            }
          },

          iconStyleData: IconStyleData(
            icon: SvgPicture.asset("assets/icons/dropdown.svg"),
          ),
          buttonStyleData: ButtonStyleData(
            height: 36,
            width: isLong ? 160 : 87,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
          ),
          dropdownStyleData: DropdownStyleData(
            width: 160,
            decoration: BoxDecoration(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
