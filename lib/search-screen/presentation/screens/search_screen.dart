import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled2/commonUI/custom_appbar.dart';

import '../../../commonUI/custom_search_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> recentWords = ["bed", "pillows", "candles"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        height: 72,
        leading: IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF0019FF), size: 20),
        ),
        title: SizedBox(
          height: 44,
          child: CustomSearchBar(
            recentWords: recentWords,
            handleSubmit: (String value) {
              setState(() {
                recentWords.add(value);
              });
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 44,
              child: Text(
                "RECENT SEARCHES",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: Color(0xFF71727A),
                ),
              ),
            ),
            Flexible(child: buildRecentWordsList()),
          ],
        ),
      ),
    );
  }

  ListView buildRecentWordsList() {
    return ListView.separated(
      itemCount: recentWords.length,
      itemBuilder: (_, index) {
        return SizedBox(
          height: 52,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                recentWords[index],
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xFF1F2024),
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onPressed: () {
                  setState(() {
                    recentWords.remove(recentWords[index]);
                  });
                },
                icon: Icon(Icons.cancel, color: Color(0xFF8F9098), size: 12),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 16);
      },
    );
  }
}
