import 'package:flutter/material.dart';

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  List<String> _navigationHistory = [];

  void _onNavigate() {
    if (_destinationController.text.isNotEmpty) {
      setState(() {
        _navigationHistory.add(_destinationController.text);
        _destinationController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search here...',
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () => print('Searching: ${_searchController.text}'),
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset('assets/images/maps.png', fit: BoxFit.cover),
          ),
          Positioned(
            //top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(icon: Icon(Icons.account_balance), onPressed: () {}),
                  IconButton(icon: Icon(Icons.wc), onPressed: () {}),
                  IconButton(icon: Icon(Icons.local_hospital), onPressed: () {}),
                  IconButton(icon: Icon(Icons.battery_charging_full), onPressed: () {}),
                ],
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => _buildBottomNavigationMenu(),
                );
              },
              child: Icon(Icons.navigation),
              tooltip: 'Navigate',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationMenu() {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75, // The initial size of the sheet when it is first opened
      minChildSize: 0.5, // The minimum size of the sheet when it is dragged down
      maxChildSize: 0.95, // Sheet can expand to 95% of the screen height
      builder: (_, controller) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.my_location),
              title: TextField(
                controller: _sourceController,
                decoration: InputDecoration(hintText: 'Source', border: InputBorder.none),
              ),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: TextField(
                controller: _destinationController,
                decoration: InputDecoration(hintText: 'Destination', border: InputBorder.none),
              ),
            ),
            ElevatedButton(
              onPressed: _onNavigate,
              child: Text('Navigate'),
            ),
            Expanded(
              child: ListView.builder(
                controller: controller, // This connects the ListView to the DraggableScrollableSheet controller
                itemCount: _navigationHistory.length,
                itemBuilder: (context, index) => ListTile(
                  leading: Icon(Icons.history),
                  title: Text(_navigationHistory[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
