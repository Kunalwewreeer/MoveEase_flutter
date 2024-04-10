import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../login_page.dart'; // Import your login page


class ProfilePage extends StatelessWidget {
  // Sample user data - can be fetched from a real data source
  final String username = "Naina";
  final String userEmail = "Nainaadventures@designthinking.com";
  final String userBio = "Muje Kya mai to Naina hu";
  final int followersCount = 510;
  final int followingCount = 6969;
  final List<String> socialMediaLinks = [
    "https://www.facebook.com/Naina",
    "https://www.twitter.com/Naina",
    "https://www.instagram.com/Naina",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$username's Profile",
          style: TextStyle(color: Color(0xFFE28A)),
        ),
        elevation: 0,
        backgroundColor: Color(0xFF67C2BF),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Navigate to login page when logout button is clicked
              //Navigator.pushReplacement(
               // context,
                //MaterialPageRoute(builder: (context) => LoginForm()),
              //);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF67C2BF),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(45)),
              ),
              padding: EdgeInsets.only(bottom: 30),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/naina2.jpg'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    username,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    userEmail,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStatWidget('Followers', followersCount),
                      SizedBox(width: 20),
                      _buildStatWidget('Following', followingCount),
                    ],
                  ),
                  SizedBox(height: 10),
                  _buildSocialMediaLinks(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                userBio,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            // Additional sections can be added here
            _buildUserPreferences(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatWidget(String label, int count) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialMediaLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: socialMediaLinks.map((link) {
        IconData icon = Icons.facebook;
        Color color = Colors.lightBlue;

        if (link.contains('facebook')) {
          icon = Icons.facebook;
          color = Colors.blue;
        } else if (link.contains('twitter')) {
          icon = Icons.bluetooth;
          color = Colors.lightBlue;
        } else if (link.contains('instagram')) {
          icon = Icons.battery_0_bar;
          color = Colors.orange;
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: IconButton(
            icon: Icon(icon, color: color),
            onPressed: () {
              // Add action here
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUserPreferences() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User Preferences',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          _buildPreferenceItem('Dark Mode', Icons.dark_mode),
          _buildPreferenceItem('Notifications', Icons.notifications),
          _buildPreferenceItem('Email Updates', Icons.email),
        ],
      ),
    );
  }

  Widget _buildPreferenceItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        // Add action here
      },
    );
  }
}
