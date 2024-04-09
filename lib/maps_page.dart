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
            top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white54, // Background for better visibility of icons
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
    return Container(
      padding: EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: [
          TextField(
            controller: _sourceController,
            decoration: InputDecoration(hintText: 'Source'),
          ),
          TextField(
            controller: _destinationController,
            decoration: InputDecoration(hintText: 'Destination'),
          ),
          ElevatedButton(
            onPressed: _onNavigate,
            child: Text('Navigate'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _navigationHistory.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(_navigationHistory[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
