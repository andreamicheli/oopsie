import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LevelController extends GetxController {
  final storage = Hive.box("storage");
  RxInt currentLevel = 0.obs;
  late var initialStoredLevel = 0;

  LevelController() : currentLevel = 0.obs {
    // Load tasks from storage or initialize with an empty list if none exist
    int? storedLevel = storage.get('currentLevel');
    if (storedLevel != null) {
      currentLevel.value = int.tryParse(storedLevel.toString()) ?? 0;
      initialStoredLevel = int.tryParse(storedLevel.toString()) ?? 0;
    }
    print('initialStoredLevel: $initialStoredLevel');
  }

  updateLevel() {
    currentLevel.value += 1;
    if (initialStoredLevel < currentLevel.value) {
      _save();
    }
  }

  setLevel(level) {
    if (initialStoredLevel < currentLevel.value) {
      currentLevel.value = level;
      _save();
    } else
      currentLevel.value = level;
  }

  void _save() {
    storage.put('currentLevel', currentLevel.value);
    print("saved");
  }
}
