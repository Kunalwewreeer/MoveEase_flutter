import 'package:flutter/material.dart';
import 'controls/feature_activation.dart';
class ControlsPage extends StatelessWidget {
  Widget featureButton({required String title, required IconData icon, required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 60), // Large icon for visibility
      label: Text(title, style: TextStyle(fontSize: 20)), // Large text for readability
      style: ElevatedButton.styleFrom(
        primary: Colors.blueAccent, // A pleasant color for the button
        onPrimary: Colors.white, // Text color
        minimumSize: Size(200, 100), // Large button size for easy interaction
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded edges for a modern look
        ),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30), // Padding for icon and text
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Controls'),
        backgroundColor: Colors.blueGrey, // Gives a technological feel
      ),
      body: SingleChildScrollView( // Ensures usability on all screen sizes
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              featureButton(
                title: 'Wheel Climbing',
                icon: Icons.settings_ethernet, // Example icon, replace as needed
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => FeatureActivationPage(featureName: 'Wheel Climbing')));// Logic for Wheel Climbing
                },
              ),
              SizedBox(height: 20),
              featureButton(
                title: 'Increase Elevation',
                icon: Icons.arrow_upward, // Example icon, replace as needed
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => FeatureActivationPage(featureName: 'Increase Elevation')));// Logic for Increasing Elevation
                },
              ),
              SizedBox(height: 30),
              Text(
                'Once activated, movement can be precisely controlled using the joystick, enabling seamless navigation and adjustment.',
                style: TextStyle(
                  fontSize: 18, // Slightly larger font for importance
                  color: Colors.blueGrey[600], // Color for a subtle, modern look
                  fontWeight: FontWeight.w400, // Medium weight for clarity
                ),
                textAlign: TextAlign.center, // Centers the text for better aesthetics
              ),
            ],
          ),
        ),
      ),
    );
  }
}
