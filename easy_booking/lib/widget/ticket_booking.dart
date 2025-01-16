import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TicketBookPage extends StatefulWidget {
  final List selectedSeats;
  final int busId;
  final int userId;
  final double totalFare;
  final int noOfSeats;

  TicketBookPage({
    required this.selectedSeats,
    required this.busId,
    required this.userId,
    required this.totalFare,
    required this.noOfSeats,
  });

  @override
  _TicketBookPageState createState() => _TicketBookPageState();
}

class _TicketBookPageState extends State<TicketBookPage> {
  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String currentDate = formatter.format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Ticket Booking'),
        backgroundColor: Color(0xffd44d57),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              Text(
                'Booking Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffd44d57),
                ),
              ),
              SizedBox(height: 20),

              // Bus Info Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bus ID: ${widget.busId}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Date: $currentDate',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Selected Seats List
              Text(
                'Selected Seats:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: widget.selectedSeats.map<Widget>((seat) {
                  return Chip(
                    label: Text(
                      seat.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.green,
                  );
                }).toList(),
              ),
              SizedBox(height: 20),

              // Fare and Seats Info
              Text(
                'Fare Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffd44d57),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Fare per Seat:',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Text(
                    '₹750',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Fare:',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Text(
                    '₹${widget.totalFare.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Payment Mode
              Text(
                'Payment Mode',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffd44d57),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.payment, color: Color(0xffd44d57)),
                  SizedBox(width: 10),
                  Text(
                    'Cash',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Confirm Booking Button
              ElevatedButton(
                onPressed: () {
                  // Proceed to confirm booking
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Booking Confirmed'),
                      content: Text('Your ticket has been successfully booked!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffd44d57),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: Text(
                  'Confirm Booking',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
