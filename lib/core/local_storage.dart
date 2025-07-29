import 'package:hive/hive.dart';
import 'package:untitled2/models/cart_item.dart';

class LocalStorage {
  static void saveData(String boxName, dynamic key, dynamic value) async {
    Box box = await Hive.openBox(boxName);

    await box.put(key, value);
  }

  static dynamic loadData(String boxName) async {
    Box box = await Hive.openBox(boxName);

    return box.values.toList();
  }

  static void clearBox(String boxName) async {
    Box box = await Hive.openBox(boxName);
    box.clear();
  }
}
