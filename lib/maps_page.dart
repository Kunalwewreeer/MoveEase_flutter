import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  List<String> _navigationHistory = [];
  final LatLng _center = const LatLng(19.1331, 72.9151);
  late GoogleMapController _mapController;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
        _mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(19.1331, 72.9151), // Example target location
        zoom: 13.0,
      ),
        ));
    
  }

  Future<void> _moveToSearchLocation() async {
    _mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(19.1331, 72.9151), // Example target location
        zoom: 15.0,
      ),
    ));
  }

  void _onNavigateButtonPressed() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _buildBottomNavigationMenu(),
    );
  }
void _onNavigate() {
  if (_destinationController.text.isNotEmpty) {
    setState(() {
      // Add the destination to the navigation history
      _navigationHistory.add(_destinationController.text);
      // Optionally, clear the destination controller if you want the user to enter a new destination next time
      _destinationController.clear();
    });
    // After updating the state to include the new destination in the history,
    // you may want to close the bottom sheet or navigate to the destination.
    // Here's how you might close the bottom sheet:
    Navigator.pop(context);
    // Then, you could potentially navigate to the destination on the map
    // This is where you'd include logic to actually use the destination for navigation
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
              onPressed: () => _moveToSearchLocation(),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: FloatingActionButton(
              onPressed: _onNavigateButtonPressed,
              child: Icon(Icons.navigation),
              backgroundColor: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationMenu() {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9, // Expanded to take more screen space
      builder: (_, controller) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                Text('Navigation', style: Theme.of(context).textTheme.titleLarge),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
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
                  trailing: Icon(Icons.navigation),
                  onTap: () {
                    // Implement onTap to use this history item for navigation
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
