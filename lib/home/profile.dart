import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class ProfilePage extends StatelessWidget {
  // Sample user data - can be fetched from a real data source
  final String username = "Alex";
  final String userEmail = "alex@example.com";
  final String userBio = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$username's Profile"),
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
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
          ],
        ),
      ),
    );
  }
}
