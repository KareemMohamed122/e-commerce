import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SortFilter extends StatefulWidget {
  const SortFilter({super.key});

  @override
  State<SortFilter> createState() => _SortFilterState();
}

class _SortFilterState extends State<SortFilter> {
  String selectedSort = 'Sort';
  final List<String> sortOptions = ['Sort', 'Price', 'Rate', 'Newest'];

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
        border: Border.all(color: Color(0xFFC5C6CC)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: [
            SvgPicture.asset("assets/icons/sort.svg"),
            SizedBox(width: 8),
            Text(
              "Filter",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Color(0xFF1F2024),
              ),
            ),
            SizedBox(width: 8),

            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Color(0xFF0019FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
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
    );
  }

  Container buildDropDownList() {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFC5C6CC)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedSort,
            icon: SvgPicture.asset("assets/icons/dropdown.svg"),

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
                          style: const TextStyle(
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
              setState(() {
                selectedSort = newValue!;
              });
            },
          ),
        ),
      ),
    );
  }
}
