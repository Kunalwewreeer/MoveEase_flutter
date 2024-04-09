import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final TextEditingController _searchController = TextEditingController();

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
              onPressed: () {
                // Handle search logic
                print('Searching: ${_searchController.text}');
              },
            ),
          ),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          // Example location: GooglePlex
          target: LatLng(37.4220, -122.0841),
          zoom: 14.4746,
        ),
        // Add your Google Maps API key here
        mapType: MapType.normal,
      ),
    );
  }
}
