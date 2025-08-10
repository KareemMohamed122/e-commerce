import 'package:equatable/equatable.dart';

abstract class SearchState {
  SearchState();
}

class SearchInitial extends SearchState {}

class RecentWordsUpdated extends SearchState {
  final List<String> recentWords;
  RecentWordsUpdated(this.recentWords);
}
