import 'package:untitled2/data/models/product.dart';

class SortList {
  static List<Product> sortList(List<Product> list, String sortOption) {
    List<Product> sortedList = List.from(list);
    switch (sortOption) {
      case 'Price:high to low':
        sortedList.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Price:low to high':
        sortedList.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Name: A to Z':
        sortedList.sort((a, b) => a.title.compareTo(b.title));
        break;

      case 'Name: Z to A':
        sortedList.sort((a, b) => b.title.compareTo(a.title));
        break;
    }
    return sortedList;
  }
}
