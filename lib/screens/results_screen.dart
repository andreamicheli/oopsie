import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Game Results'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.toNamed("/game");
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
