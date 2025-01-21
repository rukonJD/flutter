import 'package:easy_booking/widget/ui_example_05.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting dates and prices


class BusListPage extends StatelessWidget {
  final List<dynamic> busResults;

  const BusListPage({Key? key, required this.busResults}) : super(key: key);

  // Function to format the date (you may modify based on your API format)
  String formatDate(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('dd MMM yyyy').format(parsedDate);
    } catch (e) {
      return date; // If the date can't be parsed, return the original
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Available Buses"),
        backgroundColor: Color(0xffd44d57),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: busResults.isEmpty
            ? Center(child: Text("No buses found", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))
            : ListView.builder(
          itemCount: busResults.length,
          itemBuilder: (context, index) {
            var bus = busResults[index];
            return Card(
              elevation: 6,
              margin: EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bus Image (Example, you can replace with actual images from your API)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        bus['busImage'] ?? 'images/bus.png', // Placeholder image
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 16),
                    // Bus Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Bus Name and Number
                          Text(
                            "Bus : ${bus['operator']}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffd44d57),
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            "Bus No: ${bus['busNo']}",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w100,
                              color: Color(0xffd44d57),
                            ),
                          ),
                          SizedBox(height: 3),
                          // Departure Date
                          Text(
                            "Departure: ${formatDate(bus['destinationDate'])}",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          SizedBox(height: 3),
                          // Additional Information (e.g., Travel Time)
                          Text(
                            "Arrived: ${bus['arrivalDate'] ?? 'N/A'}",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    // Fare
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Fare: ${bus['price']} Tk",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffd44d57),
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to the seat selection page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SelectSeat(
                                    busId: bus['id'],
                                    date: bus['destinationDate'],
                                    fare: bus['price'],
                                    allseats: bus['seats'],
                                  operator: bus['operator'],

                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0xffd44d57),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                          child: Text("Book Now"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
