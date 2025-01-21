import 'package:easy_booking/widget/ticket_generate.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TicketBookPage extends StatefulWidget {
  final List selectedSeats;
  final int busId;
  final int userId;
  final String operator;
  final double totalFare;
  final int fare;
  final int noOfSeats;
  final Future<void> Function() bookSeats;

  TicketBookPage({
    required this.selectedSeats,
    required this.busId,
    required this.userId,
    required this.totalFare,
    required this.fare,
    required this.noOfSeats,
    required this.bookSeats,
    required this.operator,
  });

  @override
  _TicketBookPageState createState() => _TicketBookPageState();
}

class _TicketBookPageState extends State<TicketBookPage> {
  final TextEditingController _ownerNameController = TextEditingController();
  String? _selectedPaymentMode; // Selected payment mode variable
  final List<String> _paymentModes = ['CASH', 'CREDIT_CARD', 'DEBIT_CARD', 'NET_BANKING']; // List of payment modes

  Future<void> bookTicket() async {
    // Get the input values
    String ownerName = _ownerNameController.text;
    String paymentMode = _selectedPaymentMode ?? '';

    if (ownerName.isEmpty || paymentMode.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Input Missing"),
          content: Text("Please fill in all the fields."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    // Prepare the JSON data for the API request
    Map<String, dynamic> requestData = {
      "ownerName": ownerName,
      "fare": widget.fare,
      "noOfSeats": widget.noOfSeats,
      "paymentMode": paymentMode,
    };

    try {
      final url = 'http://localhost:8080/customer/api/bookT/${widget.busId}/${widget.userId}';
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(requestData),
      );

      if (response.statusCode == 200) {
        // Proceed with seat booking if ticket booking is successful
        print("Ticket booking data sent successfully.");

        // Call bookSeats method here after ticket booking API is successful
        await widget.bookSeats();

        // Show success message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Booking Confirmed"),
            content: Text('Your ticket has been successfully booked!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TicketGenerate(
                        ownerName: ownerName,
                        selectedSeats: widget.selectedSeats,
                        fare: widget.fare,
                        totalFare: widget.totalFare,
                        busId: widget.busId,
                        noOfSeats: widget.noOfSeats,
                        operator: widget.operator,
                      ),
                    ),
                  ); // Close the TicketBookPage after booking
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Show error if the API request fails
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Booking Failed"),
            content: Text("There was an issue with your ticket booking. Please try again."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      // Show error if there is a network issue or exception
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Booking Failed"),
          content: Text("There was an issue with your booking. Please try again."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

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
                        'Bus : ${widget.operator}',
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
                    '${widget.fare.toStringAsFixed(2)} Tk',
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
                    '${widget.totalFare.toStringAsFixed(2)} Tk',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 20),

              TextField(
                controller: _ownerNameController,
                decoration: InputDecoration(labelText: 'Owner Name'),
              ),

              // Payment Mode Dropdown
              DropdownButtonFormField<String>(
                value: _selectedPaymentMode,
                items: _paymentModes.map((String mode) {
                  return DropdownMenuItem<String>(
                    value: mode,
                    child: Text(mode),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPaymentMode = newValue;
                  });
                },
                decoration: InputDecoration(labelText: 'Payment Mode'),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a payment mode';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Confirm Booking Button
              ElevatedButton(
                onPressed: () {
                  bookTicket(); // Call the method to send the data and book the seats
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
