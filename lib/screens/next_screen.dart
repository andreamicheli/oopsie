import 'package:flutter/material.dart';
import 'package:forge2d_game/controller.dart';
import 'package:forge2d_game/types.dart';
import 'package:get/get.dart';

class NextScreen extends StatelessWidget {
  final levelController = Get.find<LevelController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Screen'),
      ),
      body: Center(
        child: Obx(() => levelController.currentLevel.value < 2
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Congratulations! You can proceed with the next level',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size.width > Breakpoints.md
                          ? 40
                          : size.width > Breakpoints.sm
                              ? 30
                              : 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      levelController.updateLevel();
                      Get.toNamed("/game");
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Congratulations! You completed the game',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: size.width > Breakpoints.md
                          ? 40
                          : size.width > Breakpoints.sm
                              ? 30
                              : 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed("/start");
                    },
                    child: const Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )),
      ),
    );
  }
}
