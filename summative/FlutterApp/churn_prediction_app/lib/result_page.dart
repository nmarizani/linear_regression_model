import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String prediction;

  ResultPage({required this.prediction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Prediction Result")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Prediction Result:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(prediction, style: TextStyle(fontSize: 32, color: Colors.blue)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Back"),
            )
          ],
        ),
      ),
    );
  }
}