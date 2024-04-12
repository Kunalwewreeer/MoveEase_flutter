import 'package:flutter/material.dart';

class CallInitiationPage extends StatelessWidget {
  final String featureName;

  CallInitiationPage({required this.featureName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       // title: Text('$featureName Help', style: TextStyle(color: Color(0xFFF5F2E8))),
        backgroundColor: Color(0xFF00096D),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.phone_in_talk, size: 100, color: Color(0xFF00096D)),
            SizedBox(height: 20),
            Text(
              'Initiating Call for $featureName...',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF00096D)),
            ),
          ],
        ),
      ),
    );
  }
}
