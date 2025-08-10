import 'package:untitled2/data/models/product_dto.dart';

abstract class SearchEvent {
  SearchEvent();
}

class AddRecentWord extends SearchEvent {
  final String word;

  AddRecentWord(this.word);
}

class RemoveRecentWord extends SearchEvent {
  final String word;

  RemoveRecentWord(this.word);
}

class LoadRecentWords extends SearchEvent {
  LoadRecentWords();
}
