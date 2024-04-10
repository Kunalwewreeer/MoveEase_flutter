import 'package:flutter/material.dart';
import 'sos_activation_page.dart';
class SOSPage extends StatelessWidget {
  void _showSOSConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Activate SOS'),
          content: Text('Do you want to activate SOS?'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), // Rounded corners
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Color(0xFFB54C62))),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            ElevatedButton(
              child: Text('Confirm',style: TextStyle(color: Color(0xFFF5F2E8))),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFB54C62), // Button background color
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // Rounded corners
              ),
              onPressed: () {
                // Proceed with SOS activation
                
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SOSActivationPage())); // Navigate to the SOS activation page
                // Place your SOS activation code here
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SOS'),
        backgroundColor:Color(0xFFB54C62), // Emphasizes the urgency
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.warning, size: 100, color:Color(0xFFB54C62)),
            SizedBox(height: 20),
            Text(
              'Emergency SOS',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFB54C62)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showSOSConfirmationDialog(context),
              child: Text('Send SOS Signal', style: TextStyle(color: Color(0xFFF5F2E8)),),
              style: ElevatedButton.styleFrom(primary: Color(0xFFB54C62)),
            ),
          ],
        ),
      ),
    );
  }
}
