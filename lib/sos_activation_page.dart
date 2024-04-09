import 'dart:async';
import 'package:flutter/material.dart';
import 'sos/call_initiation.dart';
class SOSActivationPage extends StatefulWidget {
  @override
  _SOSActivationPageState createState() => _SOSActivationPageState();
}

class _SOSActivationPageState extends State<SOSActivationPage> {
  Timer? _timer;
  int _start = 15;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            navigateToCallInitiation('SOS');// Timer reaches 0, proceed with SOS action
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
void navigateToCallInitiation(String featureName) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => CallInitiationPage(featureName: featureName),
  ));
}

Widget emergencyButton(String label, IconData icon, Color color) {
  return ElevatedButton.icon(
    onPressed: () => navigateToCallInitiation(label),
    icon: Icon(icon, size: 48),
    label: Text(label),
    style: ElevatedButton.styleFrom(
      primary: color,
      onPrimary: Colors.white,
      minimumSize: Size(180, 80),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SOS Activation')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("Time remaining: $_start seconds", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _timer?.cancel();
                Navigator.of(context).pop(); // Go back to previous screen
              },
              child: Text('Cancel SOS', style: TextStyle(fontSize: 20)),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                minimumSize: Size(double.infinity, 50), // make button width 100%
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            SizedBox(height: 40),
            Wrap(
              spacing: 20, // gap between adjacent chips
              runSpacing: 20, // gap between lines
              alignment: WrapAlignment.spaceBetween,
              children: <Widget>[
                emergencyButton("Medical", Icons.local_hospital, Colors.blue ),
                emergencyButton("Repairs", Icons.build, Colors.green ),
                emergencyButton("Abuse", Icons.report_problem, Colors.orange ),
                emergencyButton("Others", Icons.more_horiz, Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
