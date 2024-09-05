import 'package:hive/hive.dart';

Future<Box> _openBox(String category) async {
  return Hive.isBoxOpen(category) ? Hive.box(category) : Hive.openBox(category);
}

void addOrUpdateData(String category, String key, dynamic value) async {
  final box = await _openBox(category);
  await box.put(key, value);
  if (category == 'cache') {
    await box.put('${key}_date', DateTime.now());
  }
}
