import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartScreen extends StatelessWidget {
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
            ElevatedButton(
              onPressed: () {
                Get.toNamed("/game");
              },
              child: const Text('Start!'),
            ),
          ],
        ),
      ),
    );
  }
}
