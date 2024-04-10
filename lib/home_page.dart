import 'package:flutter/material.dart';
import 'home/profile.dart'; // Make sure to use the correct path for your profile page
import 'home/options.dart'; // Make sure to use the correct path for your options modal
import 'package:animated_background/animated_background.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  String username = "Alex"; // Example username

  @override
  Widget build(BuildContext context) {
    Color themeColor = Colors.deepPurple; // Defining a theme color

    return Scaffold(
      appBar: AppBar(
        title: Text('Hello, $username', style: TextStyle(fontSize: 20,color: Colors.white)),
        backgroundColor: themeColor, // Using the theme color
        leading: IconButton(
          icon: Icon(Icons.account_circle, size: 30),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage())),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu, size: 30),
            onPressed: () => _showOptionsModalBottomSheet(context),
          ),
        ],
        centerTitle: true,
      ),
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: ParticleOptions(
            baseColor: themeColor,
            spawnOpacity: 0.0,
            opacityChangeRate: 0.25,
            minOpacity: 0.1,
            maxOpacity: 0.4,
            particleCount: 50,
          ),
        ),
        vsync: this,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 40),
              Container(
                height: 300,
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage('assets/images/wheelchair_autocad1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              _buildInformationCard(themeColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInformationCard(Color themeColor) => Card(
    elevation: 4,
    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [themeColor.withOpacity(0.5), themeColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            // Expanded(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       _buildInfoText('Battery: 92%', themeColor),
            //       _buildInfoText('Sensors: Good', themeColor),
            //     ],
            //   ),
            // ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoText('Battery:             92%', Color.fromARGB(255, 118, 34, 68)),
                  _buildInfoText('Sensors:          Good', Color.fromARGB(255, 8, 16, 134)),
                  _buildInfoText('Electronics:    Good', Colors.yellow.shade700),
                  _buildInfoText('Device:           Not Connected', Color.fromARGB(255, 47, 56, 159)),
                  _buildInfoText('Mode:             Manual', Colors.green),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _buildInfoText(String text, Color color) => Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontFamily: 'Open Sans',
        color: color,
      ),
    ),
  );
}
void _showOptionsModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return SafeArea(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => {
                Navigator.pop(context),
                // Handle navigation or functionality for Settings
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help and Feedback'),
              onTap: () => {
                Navigator.pop(context),
                // Handle navigation or functionality for Help and Feedback
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text('Privacy Policy'),
              onTap: () => {
                Navigator.pop(context),
                // Handle navigation or functionality for Privacy Policy
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('About Us'),
              onTap: () => {
                Navigator.pop(context),
                // Handle navigation or functionality for About Us
              },
            ),
          ],
        ),
      );
    },
  );
}