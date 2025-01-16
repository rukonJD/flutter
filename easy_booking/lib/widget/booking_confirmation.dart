import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookingConfirmationPage extends StatelessWidget {
  final dynamic ticketDetails;

  BookingConfirmationPage({required this.ticketDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ticket Booking Confirmation"),
        backgroundColor: Color(0xffd44d57),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Booking Confirmed!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('Ticket Details:', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Seats: ${ticketDetails['seats'].join(', ')}'),
            Text('Fare: ₹${ticketDetails['fare']}'),
            Text('User: ${ticketDetails['ownerName']}'),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to previous page
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xffd44d57),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }
}