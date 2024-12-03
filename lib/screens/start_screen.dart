import 'package:flutter/material.dart';
import 'package:forge2d_game/controller.dart';
import 'package:get/get.dart';

class StartScreen extends StatelessWidget {
  final levelController = Get.find<LevelController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oopsie!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                'Try to avoid the obstacles while subdividing as much as you can!'),
            const SizedBox(height: 20),
            Column(
              children: [
                ElevatedButton(
                  onPressed: levelController.currentLevel.value < 0
                      ? null
                      : () {
                          levelController.setLevel(0);
                          Get.toNamed("/game");
                        },
                  child: const Text('Level 1'),
                ),
                ElevatedButton(
                  onPressed: levelController.currentLevel.value < 1
                      ? null
                      : () {
                          levelController.setLevel(1);
                          Get.toNamed("/game");
                        },
                  child: const Text('Level 2'),
                ),
                ElevatedButton(
                  onPressed: levelController.currentLevel.value < 2
                      ? null
                      : () {
                          levelController.setLevel(2);
                          Get.toNamed("/game");
                        },
                  child: const Text('Level 3'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
