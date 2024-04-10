import 'package:flutter/material.dart';
import 'home/profile.dart'; // Make sure to use the correct path for your profile page
import 'home/options.dart'; // Make sure to use the correct path for your options modal
import 'package:animated_background/animated_background.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  String username = "Naina"; // Example username

  // Data for each information card
  final List<Map<String, dynamic>> infoCards = [
    {'title': 'Battery', 'value': '92%', 'icon': Icons.battery_full},
    {'title': 'Sensors', 'value': 'Good', 'icon': Icons.sensor_door},
    {'title': 'Electronics', 'value': 'Good', 'icon': Icons.electrical_services},
    {'title': 'Device', 'value': 'Not Connected', 'icon': Icons.phonelink_off},
  ];

  @override
  Widget build(BuildContext context) {
    Color themeColor = const Color(0xFF67C2BF); // Defining a theme color

    return Scaffold(
      appBar: AppBar(
        title: Text('Hello, $username', style: TextStyle(fontSize: 20, color: Color(0xFFF5F2E8))),
        backgroundColor: themeColor, // Using the theme color
        leading: IconButton(
          icon: Icon(Icons.account_circle, size: 40),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage())),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu, size: 40),
            onPressed: () => _showOptionsModalBottomSheet(context),
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/wheelchair_autocad1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: infoCards.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _showSensitivityPopup(context, infoCards[index]['title']),
                  child: Card(
                    child: Container(
                      width: 150,
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
        ],
      ),
    );
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


  Widget _buildInfoText(String text, Color color) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 20,
        //fontFamily: 'Open Sans',
        color: color,
      ),
    ),
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