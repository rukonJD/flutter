import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RedBusSeatUI extends StatefulWidget {
  final int busId;
  final String date;

  const RedBusSeatUI({Key? key, required this.busId, required this.date}) : super(key: key);

  @override
  _RedBusSeatUIState createState() => _RedBusSeatUIState();
}

class _RedBusSeatUIState extends State<RedBusSeatUI> {
  List<Map<String, dynamic>> seats = [];
  List<int> selectedSeats = [];

  @override
  void initState() {
    super.initState();
    // Initialize with seat statuses (mock data for the sake of demonstration)
    seats = List.generate(20, (index) {
      return {'id': index + 1, 'status': 'available'};
    });
  }

  void toggleSeatSelection(int seatId) {
    setState(() {
      var seat = seats.firstWhere((seat) => seat['id'] == seatId);
      if (seat['status'] == 'available') {
        seat['status'] = 'selected';
        selectedSeats.add(seatId);
      } else if (seat['status'] == 'selected') {
        seat['status'] = 'available';
        selectedSeats.remove(seatId);
      }
    });
  }

  Future<void> bookSeats() async {
    if (selectedSeats.isEmpty) {
      // If no seats are selected, show a warning message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("No Seats Selected"),
          content: Text("Please select at least one seat to book."),
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

    // Send the API request to book the selected seats
    final url = 'http://localhost:8080/customer/api/bookSeat';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'busId': widget.busId.toString(),
        'date': widget.date,
        'noOfSeats': selectedSeats.length.toString(),
        // You can pass seat IDs if needed
        'seats': selectedSeats.join(','),
      },
    );

    if (response.statusCode == 200) {
      // Successful booking
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Booking Successful"),
          content: Text("Your seats have been booked successfully."),
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
    } else {
      // Handle error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Booking Failed"),
          content: Text("There was an issue with your booking. Please try again."),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Easy Booking"),
        backgroundColor: Color(0xffd44d57),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Bus ID: ${widget.busId}, Date: ${widget.date}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Wrapping the GridView inside a SingleChildScrollView to prevent touch conflicts
            Expanded(
              child: SingleChildScrollView(
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: seats.length,
                  itemBuilder: (context, index) {
                    var seat = seats[index];
                    Color seatColor;
                    if (seat['status'] == 'available') {
                      seatColor = Colors.green;
                    } else if (seat['status'] == 'selected') {
                      seatColor = Colors.blue;
                    } else {
                      seatColor = Colors.red;
                    }

                    return GestureDetector(
                      onTap: () => toggleSeatSelection(seat['id']),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: seatColor,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: bookSeats, // Call bookSeats function
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xffd44d57),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: Text("Confirm Booking"),
            ),
          ],
        ),
      ),
    );
  }
}
