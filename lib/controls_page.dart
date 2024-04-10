import 'package:flutter/material.dart';
// Make sure you import the BarChartSample2 widget correctly
import 'controls/chart.dart';
import 'controls/feature_activation.dart'; // Ensure this path is correct

class ControlsPage extends StatelessWidget {
  Widget featureButton({required String title, required IconData icon, required VoidCallback onPressed}) {
    return Container(
      margin: EdgeInsets.only(bottom: 20), // Adds space between buttons
      width: double.infinity, // Makes the button take the full width of its parent container
      height: 120, // Increases height for a squarish look
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 40, // Adjusts icon size for balance with the squarish button
        ),
        label: Padding(
          padding: const EdgeInsets.only(left: 10), // Adds some space between the icon and the text
          child: Text(
            title,
            style: TextStyle(fontSize: 24), // Adjusts font size for readability
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent, // Pleasant color for the button
          foregroundColor: Colors.white, // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Rounded edges for a modern look
          ),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20), // Adjusts padding for icon and text
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Controls'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              featureButton(
                title: 'Stair Climbing',
                icon: Icons.settings_ethernet,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => FeatureActivationPage(featureName: 'Stair Climbing')));
                },
              ),
              featureButton(
                title: 'Increase Elevation',
                icon: Icons.arrow_upward,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => FeatureActivationPage(featureName: 'Increase Elevation')));
                },
              ),
              SizedBox(height: 20),
              Text(
                'Once activated, movement can be precisely controlled using the joystick, enabling seamless navigation and adjustment.',
                style: TextStyle(fontSize: 18, color: Colors.blueGrey[600], fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              // Add the BarChartSample2 widget here
              BarChartSample2(),
            ],
          ),
        ),
      ),
    );
  }
}
