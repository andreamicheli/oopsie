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
              'Oopsie!',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Try to avoid the obstacles!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 420,
              child: const Text(
                'Touch the screen on the right side and left side to move in the respective directions. Collect 25 points to unlock the next level.',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 50),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: levelController.currentLevel.value < 0
                        ? null
                        : () {
                            levelController.setLevel(0);
                            Get.toNamed("/game");
                          },
                    child: const Text(
                      'Level 1',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: levelController.currentLevel.value < 1
                          ? null
                          : () {
                              levelController.setLevel(1);
                              Get.toNamed("/game");
                            },
                      child: const Text(
                        'Level 2',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: levelController.currentLevel.value < 2
                          ? null
                          : () {
                              levelController.setLevel(2);
                              Get.toNamed("/game");
                            },
                      child: const Text(
                        'Level 3',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
