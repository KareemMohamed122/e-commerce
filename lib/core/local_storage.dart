import 'package:hive/hive.dart';
import 'package:untitled2/models/cart_item.dart';

class LocalStorage {
  static void saveData(String boxName, dynamic key, dynamic value) async {
    Box box = Hive.box<CartItem>(boxName);
    await box.put(key, value);
  }

  static dynamic loadData(String boxName) {
    Box box = Hive.box<CartItem>(boxName);
    return box.values.toList();
  }

  static void clearBox(String boxName) {
    Box box = Hive.box<CartItem>(boxName);
    box.clear();
  }
}
