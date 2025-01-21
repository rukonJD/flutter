import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketGenerate extends StatefulWidget {
  final String ownerName;
  final String operator;
  final List selectedSeats;
  final int fare;
  final double totalFare;
  final int busId;
  final int noOfSeats;

  TicketGenerate({
    required this.ownerName,
    required this.selectedSeats,
    required this.fare,
    required this.totalFare,
    required this.busId,
    required this.noOfSeats,
    required this.operator,
  });

  @override
  _TicketGenerateState createState() => _TicketGenerateState();
}

class _TicketGenerateState extends State<TicketGenerate> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the QR data
    String qrData = 'Owner: ${widget.ownerName}\n'
        'Bus ID: ${widget.busId}\n'
        'Seats: ${widget.noOfSeats}\n'
        'Fare per Seat: ${widget.fare}\n'
        'Total Fare: ${widget.totalFare}\n'
        'Seats: ${widget.selectedSeats.join(', ')}';

    _controller = TextEditingController(text: qrData);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ticket Details"),
        backgroundColor: Color(0xffd44d57),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ticket Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xffd44d57),
              ),
            ),
            SizedBox(height: 20),
            Text('Owner Name: ${widget.ownerName}'),
            SizedBox(height: 10),
            Text('Bus ID: ${widget.busId}'),
            SizedBox(height: 10),
            Text('No of Seats: ${widget.noOfSeats}'),
            SizedBox(height: 10),
            Text('Fare per Seat: ${widget.fare} Tk'),
            SizedBox(height: 10),
            Text('Total Fare: ${widget.totalFare} Tk'),
            SizedBox(height: 20),
            Text('Selected Seats:'),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: widget.selectedSeats.map<Widget>((seat) {
                return Chip(
                  label: Text(seat.toString()),
                  backgroundColor: Colors.green,
                );
              }).toList(),
            ),
            SizedBox(height: 30),

            // Display QR Code
            Center(
              child: SizedBox(
                width: 200.0,  // Set width of the QR code
                height: 200.0, // Set height of the QR code
                child: QrImageView(
                  data: _controller.text,  // Dynamic QR code data based on the controller's text
                  size: 200.0,  // Size of the QR code
                  backgroundColor: Colors.white,  // Background color for the QR code
                  foregroundColor: Color(0xffd44d57),  // QR code color
                  embeddedImageStyle: QrEmbeddedImageStyle(
                    size: const Size(100, 100),
                  ),  // Optional embedded image for the QR code
                ),
              ),
            ),
            SizedBox(height: 30),

            // Back to Home Button
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/')); // This will pop back to the home screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffd44d57),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: Text(
                'Back to Home',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
