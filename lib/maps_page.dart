import 'dart:async';

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
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _addMarkers();
    _highlightRoadSections();
  }

  void _addMarkers() {
    // Add markers with custom icons
    _markers.add(
      Marker(
        markerId: MarkerId('repair_shop'),
        position: LatLng(19.134, 72.916),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        infoWindow: InfoWindow(
          title: 'Repair Shop',
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('medical_assistance'),
        position: LatLng(19.132, 72.914),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: InfoWindow(
          title: 'Medical Assistance',
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('ramps'),
        position: LatLng(19.1335, 72.915),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(
          title: 'Ramps',
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('crowd'),
        position: LatLng(19.135, 72.917),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        infoWindow: InfoWindow(
          title: 'Crowd',
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('fire_elevations'),
        position: LatLng(19.136, 72.918),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(
          title: 'Fire Elevations',
        ),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId('construction_site'),
        position: LatLng(19.137, 72.919),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        infoWindow: InfoWindow(
          title: 'Construction Site',
        ),
      ),
    );
    // Add more markers as needed
  }

  void _highlightRoadSections() {
    // Draw polylines to highlight road sections
    _polylines.add(
      Polyline(
        polylineId: PolylineId('road1'),
        points: [
          LatLng(19.1335, 72.913),
          LatLng(19.134, 72.914),
          LatLng(19.135, 72.915),
          // Add more points to define the road section
        ],
        color: Colors.red,
        width: 5,
      ),
    );
    _polylines.add(
      Polyline(
        polylineId: PolylineId('road2'),
        points: [
          LatLng(19.132, 72.914),
          LatLng(19.133, 72.915),
          LatLng(19.134, 72.916),
          // Add more points to define the road section
        ],
        color: Colors.blue,
        width: 5,
      ),
    );
    // Add more polylines as needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5DA9F9),
        foregroundColor: Colors.white,
        title: TextField(
          style: TextStyle(color: Colors.white),
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search for a location',
           // hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () => _moveToSearchLocation(),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 90,
            color: Color(0xFF5DA9F9),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(vertical: 10),
              children: [
                _buildMarkerButton('Repair', Icons.build),
                _buildMarkerButton('Medical', Icons.local_hospital),
                _buildMarkerButton('Ramps', Icons.accessibility),
                _buildMarkerButton('Crowd', Icons.group),
                _buildMarkerButton('Elevators', Icons.fire_extinguisher),
                _buildMarkerButton('Construction', Icons.construction),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 13.0,
                  ),
                  markers: _markers,
                  polylines: _polylines,
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
          ),
        ],
      ),
    );
  }

  Widget _buildMarkerButton(String label, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          IconButton(
            icon: Icon(icon),
            onPressed: () {
              // Add functionality to handle marker button tap
            },
          ),
          Text(label),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: _center,
        zoom: 13.0,
      ),
    ));
  }

  Future<void> _moveToSearchLocation() async {
    _mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: _center,
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
        _navigationHistory.add(_destinationController.text);
        _destinationController.clear();
      });
      Navigator.pop(context);
    }
  }

  Widget _buildBottomNavigationMenu() {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      builder: (_, controller) => Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  'Navigation',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.my_location),
              title: TextField(
                controller: _sourceController,
                decoration: InputDecoration(
                  hintText: 'Enter source',
                  border: InputBorder.none,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: TextField(
                controller: _destinationController,
                decoration: InputDecoration(
                  hintText: 'Enter destination',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onNavigate,
              child: Text('Navigate'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                controller: controller,
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
