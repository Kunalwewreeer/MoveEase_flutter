import 'package:flutter/material.dart';
import 'controls/chart.dart';
import 'package:animated_background/animated_background.dart';
import 'controls/feature_activation.dart';

class ControlsPage extends StatelessWidget {
  Widget featureButton({required String title, required IconData icon, required VoidCallback onPressed}) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: double.infinity,
      height: 120,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 40,
        ),
        label: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            title,
            style: TextStyle(fontSize: 24),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF67C2BF),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          elevation: 5, // Add elevation for shadow effect
          shadowColor: Colors.black, // Set shadow color
          animationDuration: Duration(milliseconds: 300), // Set animation duration
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Remove app bar elevation
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background_image.avif'), // Change this to your background image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: kToolbarHeight), // Add space for the app bar
                  featureButton(
                    title: 'Stair Climbing',
                    icon: Icons.settings_ethernet,
                    onPressed: () {
                      _navigateToFeatureActivationPage(context, 'Stair Climbing');
                    },
                  ),
                  featureButton(
                    title: 'Increase Elevation',
                    icon: Icons.arrow_upward,
                    onPressed: () {
                      _navigateToFeatureActivationPage(context, 'Increase Elevation');
                    },
                  ),
                  // SizedBox(height: 20),
                  // Text(
                  //   'Once activated, movement can be precisely controlled using the joystick, enabling seamless navigation and adjustment.',
                  //   style: TextStyle(fontSize: 18, color: Color(0xFFFFE28A), fontWeight: FontWeight.w400),
                  //   textAlign: TextAlign.center,
                  // ),
                  SizedBox(height: 20),
                  // Add the BarChartSample2 widget here
                  //BarChartSample2(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToFeatureActivationPage(BuildContext context, String featureName) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => FeatureActivationPage(featureName: featureName)));
  }
}
