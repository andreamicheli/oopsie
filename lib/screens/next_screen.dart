import 'package:flutter/material.dart';
import 'package:forge2d_game/controller.dart';
import 'package:get/get.dart';

class NextScreen extends StatelessWidget {
  final levelController = Get.find<LevelController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Screen'),
      ),
      body: Center(
        child: Obx(() => levelController.currentLevel.value < 2
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                      'Congratulations! You can proceed with the next level'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      levelController.updateLevel();
                      Get.toNamed("/game");
                    },
                    child: const Text('Next'),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Congratulations! You completed the game'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed("/start");
                    },
                    child: const Text('Home'),
                  ),
                ],
              )),
      ),
    );
  }
}
