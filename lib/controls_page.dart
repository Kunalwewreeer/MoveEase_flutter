import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:convert'; // For utf8.encode
import 'dart:typed_data'; // For Uint8List
import 'dart:async';
import 'controls/chart.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:animated_background/animated_background.dart';
import 'controls/feature_activation.dart';

class ControlsPage extends StatefulWidget {
  @override
  _ControlsPageState createState() => _ControlsPageState();
}

class _ControlsPageState extends State<ControlsPage> {
  BluetoothConnection? connection;
  bool isConnecting = true;
  bool get isConnected => connection != null && connection!.isConnected;
  bool isLedOn = false;
  int lastVibrationValue = 0;
  int currentVibrationValue = 0;


  @override
  void initState() {
    super.initState();
    requestBluetoothPermissions();
    connectToHC05();
  }
  Future<void> requestBluetoothPermissions() async {
  // Request BLUETOOTH_CONNECT permission for Android 12 and above
  if (await Permission.bluetoothConnect.request().isGranted && await Permission.bluetoothScan.request().isGranted) {
    // Permission is granted. You can proceed with Bluetooth operations.
    print("Bluetooth connect permission granted.");
  } else {
    // Handle the case where permission is denied.
    print("Bluetooth connect permission denied.");
  }
}
  Future<void> connectToHC05() async {
    try {
      // Attempt to discover the HC-05 device from paired devices.
      List<BluetoothDevice> devices = await FlutterBluetoothSerial.instance.getBondedDevices();
      BluetoothDevice? hc05Device = devices.firstWhere((device) => device.name == "HC-05", orElse: () => BluetoothDevice(address: ''));

      if (hc05Device != null) {
        // If HC-05 device is found, attempt to connect.
        await BluetoothConnection.toAddress(hc05Device.address).then((_connection) {
          print('Connected to the HC-05 device');
          connection = _connection;

          connection!.input!.listen(_onDataReceived).onDone(() {
            // Handle disconnection
          });
        }).catchError((error) {
          print('Cannot connect, exception occurred');
          print(error);
        });
      } else {
        print('HC-05 device not found');
      }
    } catch (exception) {
      print('Error occurred');
    }
  }

  void _onDataReceived(Uint8List data) {
  String dataStr = ascii.decode(data).trim();
  int value = int.tryParse(dataStr) ?? 0;
  if(mounted) {
  setState(() {
    lastVibrationValue = currentVibrationValue;
    currentVibrationValue = value;
  });
  }
  //print('Data incoming: $dataStr');
}

  void sendToHC05(String command) async {
    if (isConnected) {
      connection!.output.add(Uint8List.fromList(utf8.encode(command)));
      await connection!.output.allSent;
      print("Command $command sent");
    } else {
      print("Not connected to HC-05");
    }
  }
void showVibrationOrProximityValueDialog(int flag) {
  Timer? timer; // Declare a Timer
  showDialog(
    context: context,
    builder: (BuildContext context) {
      timer = Timer.periodic(Duration(milliseconds: 500), (Timer t) {
        // Force an update to the dialog's content
        (context as Element).markNeedsBuild();
      });

      // Simplified normalization calculation and title based on flag
      double maxValue = flag == 0 ? 20.0 : 100.0; // Max value depends on flag
      double normalizedValue = ((currentVibrationValue - lastVibrationValue).abs() % (maxValue + 1)) / maxValue;
      String title = flag == 0 ? "Vibration" : "Proximity";
      if (flag == 1){
        normalizedValue = currentVibrationValue/100;
        lastVibrationValue = 0;
        currentVibrationValue = currentVibrationValue - currentVibrationValue%100;
     }
     
      return AlertDialog(
        content: StatefulBuilder(
          builder: (context, setState) {
            // Determine color based on normalizedValue
            Color barColor = normalizedValue > 0.5 ? Colors.red : Colors.blue;
            
            return SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  
                  Text("$title: ${(currentVibrationValue - lastVibrationValue).abs()}", textAlign: TextAlign.center,),
                  SizedBox(height: 20), // Add some spacing
                  LinearProgressIndicator(
                    value: normalizedValue,
                    backgroundColor: Colors.grey[300],
                    // Use AlwaysStoppedAnimation to apply the dynamic color
                    valueColor: AlwaysStoppedAnimation<Color>(barColor),
                  ),
                ],
              ),
            );
          },
        ),
        actions: <Widget>[
          TextButton(
            child: Text("Close"),
            onPressed: () {
              timer?.cancel(); // Stop the timer when dialog is closed
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  ).then((value) {
    timer?.cancel(); // Ensure the timer is canceled when the dialog is dismissed
  });
}




  void toggleLED() async {
    final String command = isLedOn ? '0' : '1';
    //connectToHC05();
    sendToHC05(command);
    if (mounted){
    setState(() {
      isLedOn = !isLedOn; // Toggle the state
    });}
  }

  @override
  void dispose() {
    // Dispose the Bluetooth connection
    connection?.dispose();
    super.dispose();
  }
  Widget featureButton({
    required String title,
    required IconData icon,
    required VoidCallback onPressed,
    Color? backgroundColor, // Allow custom background color
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: double.infinity,
      height: 120,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 40),
        label: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(title, style: TextStyle(fontSize: 24)),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Color(0xFF5DA9F9), // Use provided color or default
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          elevation: 5,
          shadowColor: Colors.black,
          animationDuration: Duration(milliseconds: 300),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_image.avif'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: kToolbarHeight),
                  featureButton(
                    title: 'Stair Climbing',
                    icon: Icons.settings_ethernet,
                    onPressed: () => _navigateToFeatureActivationPage(context, 'Stair Climbing'),
                  ),
                  featureButton(
                    title: 'Increase Elevation',
                    icon: Icons.arrow_upward,
                    onPressed: () => _navigateToFeatureActivationPage(context, 'Increase Elevation'),
                  ),
                  featureButton(
                    title: 'Toggle LED',
                    icon: Icons.lightbulb_outline,
                    onPressed: toggleLED, // Toggle LED function
                    backgroundColor: isLedOn ? Colors.green : null, // Change color if LED is on
                  ),
                  featureButton(
                    title: 'Vibration Detector',
                    icon: Icons.vibration,
                    onPressed: () => showVibrationOrProximityValueDialog(0),
                  ),
                  featureButton(
                    title: 'Proximity Sensor',
                    icon: Icons.sensor_window,
                    onPressed: () => showVibrationOrProximityValueDialog(1),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToFeatureActivationPage(BuildContext context, String featureName) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => FeatureActivationPage(featureName: featureName)));
  }


}
