import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:untitled2/bloc/product/product_bloc.dart';
import 'package:untitled2/bloc/product/product_event.dart';
import 'package:untitled2/bloc/search/search_bloc.dart';
import 'package:untitled2/bloc/search/search_event.dart';
import 'package:untitled2/bloc/search/search_state.dart';
import 'package:untitled2/commonUI/custom_appbar.dart';
import 'package:untitled2/commonUI/custom_search_bar.dart';
import 'package:untitled2/core/injection.dart';
import 'package:untitled2/search_results_screen/presentation/screens/search_results_screen.dart';
import '../../../commonUI/navigation_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchBloc = getIt<SearchBloc>();
  final productBloc = getIt<ProductBloc>();

  @override
  void initState() {
    super.initState();
    searchBloc.add(LoadRecentWords());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: searchBloc),
        BlocProvider.value(value: productBloc),
      ],
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppbar(
              height: 72,
              leading: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  Get.offAll(() => const NavigationBarMenu(currentIndex: 0));
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFF0019FF),
                  size: 20,
                ),
              ),
              title: SizedBox(
                height: 44,
                child:
                    state is RecentWordsUpdated
                        ? CustomSearchBar(
                          recentWords: state.recentWords,
                          handleSubmit: (String value) {
                            context.read<SearchBloc>().add(
                              AddRecentWord(value),
                            );
                            context.read<ProductBloc>().add(
                              LoadProductsByTitle(value),
                            );
                            Get.to(() => const SearchResultsScreen());
                          },
                          filterByCategory: false,
                        )
                        : const SizedBox(),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child:
                  state is RecentWordsUpdated
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
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
                          Expanded(
                            child: buildRecentWordsList(state.recentWords),
                          ),
                        ],
                      )
                      : const Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }

  ListView buildRecentWordsList(List<String> recentWords) {
    return ListView.separated(
      itemCount: recentWords.length,
      itemBuilder: (_, index) {
        return InkWell(
          onTap: () {
            context.read<ProductBloc>().add(
              LoadProductsByTitle(recentWords[index]),
            );
            Get.to(() => const SearchResultsScreen());
          },
          child: SizedBox(
            height: 52,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  recentWords[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xFF1F2024),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    context.read<SearchBloc>().add(
                      RemoveRecentWord(recentWords[index]),
                    );
                  },
                  icon: const Icon(
                    Icons.cancel,
                    color: Color(0xFF8F9098),
                    size: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 16);
      },
    );
  }
}
