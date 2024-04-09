import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  // Example username
  String username = "Alex";

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
              // Action for the menu button
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
              height: 300, // Increased height for a squarish shape
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.blueAccent[100],
                borderRadius: BorderRadius.circular(20), // Rounded corners
              ),
              child: Center(child: Text('Animation Placeholder', style: TextStyle(color: Colors.white, fontSize: 24))),
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.blueGrey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Center(child: Text("Profile Page", style: TextStyle(fontSize: 24))),
    );
  }
}
