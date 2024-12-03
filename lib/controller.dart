import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LevelController extends GetxController {
  final storage = Hive.box("storage");
  RxInt currentLevel = 0.obs;

  LevelController() : currentLevel = 0.obs {
    // Load tasks from storage or initialize with an empty list if none exist
    int? storedLevel = storage.get('currentLevel');
    if (storedLevel != null) {
      currentLevel.value = int.tryParse(storedLevel.toString()) ?? 0;
    }
  }

  updateLevel() {
    currentLevel.value += 1;
    _save();
  }

  void _save() {
    storage.put('currentLevel', currentLevel);
  }
}
