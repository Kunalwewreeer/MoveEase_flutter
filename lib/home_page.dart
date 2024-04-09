import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'maps_page.dart';
import 'home/profile.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Example username
  String username = "Alex";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello, $username', style: TextStyle(fontSize: 20)),
        leading: IconButton(
          icon: Icon(Icons.account_circle, size: 30), // Increased icon size
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage())),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu, size: 30), // Increased icon size
            onPressed: () {
              _showOptionsModalBottomSheet(context);// Action for the menu button
            },
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 40), // More space from the top
            Container(
              height: 300,
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage('assets/images/wheelchair_autocad1.png'), // Use your actual image path here
                  fit: BoxFit.cover, // This ensures the image covers the container, you can adjust as needed
                ),
              ),
            ),
            Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <String>[
                    'Battery: 92%',
                    'Sensors: Good',
                    'Electronics: Good',
                    'Device: Not Connected',
                    'Mode: Manual',
                  ]
                  .map((String value) => Padding(
                    padding: const EdgeInsets.only(bottom: 10), // Space between lines
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 20, // Larger font size for details
                        fontWeight: FontWeight.w500, // Medium weight for readability
                        color: Colors.blueGrey[900], // Darker text for contrast
                      ),
                    ),
                  ))
                  .toList(),
                ),
              ),
            ),
          ],
        ),
      ),


    );
  }
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
