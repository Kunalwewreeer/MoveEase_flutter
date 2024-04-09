import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class FeatureActivationPage extends StatefulWidget {
  final String featureName;

  FeatureActivationPage({required this.featureName});

  @override
  _FeatureActivationPageState createState() => _FeatureActivationPageState();
}

class _FeatureActivationPageState extends State<FeatureActivationPage> {
  bool? _isActivated;
  final _random = Random();

  @override
  void initState() {
    super.initState();
    // Simulate feature activation process
    Timer(Duration(seconds: 2), () {
      final isSuccess = _random.nextBool(); // Randomly decide if activation is successful
      setState(() {
        _isActivated = isSuccess;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.featureName} Activation'),
      ),
      body: Center(
        child: _isActivated == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Please wait: The feature is initiating'),
                ],
              )
            : _isActivated == true
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, color: Colors.green, size: 60),
                      SizedBox(height: 20),
                      Text('Feature Activated', style: TextStyle(fontSize: 24, color: Colors.green)),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, color: Colors.red, size: 60),
                      SizedBox(height: 20),
                      Text('Feature Failed', style: TextStyle(fontSize: 24, color: Colors.red)),
                    ],
                  ),
      ),
    );
  }
}
