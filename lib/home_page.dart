import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'home/profile.dart';
import 'home/options.dart';
import 'controls_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  String username = "Naina";
  int? selectedCardIndex;
  BluetoothConnection? connection;
  List<BluetoothDevice> devicesList = [];
  bool isConnecting = true;
  bool get isConnected => connection != null && connection!.isConnected;

  final List<Map<String, dynamic>> infoCards = [
    {'title': 'Battery', 'value': '92%', 'icon': Icons.battery_full},
    {'title': 'Sensors', 'value': 'Critical', 'icon': Icons.sensor_door},
    {'title': 'Electronics', 'value': 'Good', 'icon': Icons.electrical_services},
    {'title': 'Device', 'value': 'Not Connected', 'icon': Icons.phonelink_off},
  ];

  @override
  void initState() {
    super.initState();
    FlutterBluetoothSerial.instance.onStateChanged().listen((state) {
      setState(() {});
    });
    checkCriticalStatus();
    fetchBondedDevices(); 
    updateDeviceInfo();
  }
    void updateDeviceInfo() {
    setState(() {
      // Update the connection status dynamically
      infoCards[3]['value'] = isConnected ? 'Connected' : 'Not Connected';
    });
  }

  void fetchBondedDevices() async {
    devicesList = await FlutterBluetoothSerial.instance.getBondedDevices();
  }

  void connectToHC05() async {
    // Specific logic to connect to HC-05, this assumes you know the device is paired
    BluetoothDevice? hc05Device = devicesList.firstWhere(
      (device) => device.name == "HC-05",

    );
    updateDeviceInfo();
    if (hc05Device != null) {
      await BluetoothConnection.toAddress(hc05Device.address).then((_connection) {
        print('Connected to the device');
        setState(() {
          connection = _connection;
          updateDeviceInfo();  // Update device connection status dynamically
        });
      }).catchError((error) {
        
        print('Cannot connect, exception occurred');
        print(error);
      });
    } else {
      print('HC-05 device not found');
      // Optionally, start a discovery process here or alert the user
    }
  }

  void checkCriticalStatus() {
    for (var card in infoCards) {
      if (card['value'] == 'Critical') {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Alert"),
                content: Text("${card['title']} is in a critical status."),
                actions: <Widget>[
                  TextButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            },
          );
        });
        break; // Stop after the first critical alert to avoid multiple dialogs
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.72,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/wheelchair_autocad1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: infoCards.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCardIndex = selectedCardIndex == index ? null : index;  // This toggles the selected state visually
                                });
                                // Check the title to determine action
                                if (infoCards[index]['title'] == 'Sensors') {
                                  _showSensitivityPopup(context, infoCards[index]['title']);
                                } else if (infoCards[index]['title'] == 'Device' && !isConnected) {
                                  updateDeviceInfo();
                                  if(isConnected == false){
                                  connectToHC05();  // Attempt to connect to HC-05 if not connected
                                  }
                                }
                                // Add other conditions if there are more specific actions for other cards
                              },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width: selectedCardIndex == index ? 180 : 150,
                            curve: Curves.easeInOut,
                            child: Card(
                              elevation: selectedCardIndex == index ? 8 : 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(infoCards[index]['icon'], size: 40),
                                  Text(infoCards[index]['title']),
                                  Text(infoCards[index]['value']),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 40,
              left: 10,
              child: IconButton(
                icon: Icon(Icons.account_circle, size: 40),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage())),
              ),
            ),
            Positioned(
              top: 40,
              right: 10,
              child: IconButton(
                icon: Icon(Icons.menu, size: 40),
                onPressed: () => _showOptionsModalBottomSheet(context),
              ),
            ),
            Positioned(
              left: 150,
              top: 53,
              child: Text('Hello, $username', style: TextStyle(fontSize: 20, color: Colors.black)),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      fetchBondedDevices(); // Update the list of bonded devices on refresh
    });
  }
}

  void _showSensitivityPopup(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("$title Sensitivity"),
          content: Slider(
            value: 50,
            min: 0,
            max: 100,
            divisions: 5,
            label: 'Sensitivity',
            onChanged: (double value) {},
          ),
          actions: <Widget>[
            FloatingActionButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showOptionsModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () => {
                  Navigator.pop(context),
                  // Handle navigation or functionality for Settings
                },
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text('Help and Feedback'),
                onTap: () => {
                  Navigator.pop(context),
                  // Handle navigation or functionality for Help and Feedback
                },
              ),
              ListTile(
                leading: Icon(Icons.privacy_tip),
                title: Text('Privacy Policy'),
                onTap: () => {
                  Navigator.pop(context),
                  // Handle navigation or functionality for Privacy Policy
                },
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('About Us'),
                onTap: () => {
                  Navigator.pop(context),
                  // Handle navigation or functionality for About Us
                },
              ),
            ],
          ),
        );
      },
    );
  }

