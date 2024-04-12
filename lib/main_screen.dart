import 'package:flutter/material.dart';
import 'maps_page.dart'; // Assume this is your MapsScreen
import 'home_page.dart'; // Your HomePage
import 'controls_page.dart'; // Placeholder for your Controls screen
import 'sos_page.dart'; // Placeholder for your SOS screen

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of widgets to use as bodies for the navigation bar
  final List<Widget> _widgetOptions = [
    HomePage(),
    MapsScreen(),
    ControlsPage(), // Placeholder for your Controls screen
    SOSPage(), // Placeholder for your SOS screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Maps'),
          BottomNavigationBarItem(icon: Icon(Icons.toggle_on), label: 'Controls'),
          BottomNavigationBarItem(icon: Icon(Icons.warning), label: 'SOS'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF5DA9F9), // Set the selected item color
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
