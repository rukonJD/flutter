import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RedBusSeatUI extends StatefulWidget {
  final int busId;
  final String date;
  final List allseats;


  const RedBusSeatUI({Key? key, required this.busId, required this.date,required this.allseats}) : super(key: key);

  @override
  _RedBusSeatUIState createState() => _RedBusSeatUIState();
}

class _RedBusSeatUIState extends State<RedBusSeatUI> {
  List<Map<String, dynamic>> seats = [];
  List<int> selectedSeats = [];
  List selectedSit=[];

  @override
  void initState() {
    super.initState();
    getSeats();
    // Initialize with seat statuses (mock data for the sake of demonstration)
    // seats = List.generate(20, (index) {
    //   return {'id': index + 1, 'status': 'available'};
    // });
  }

  void getSeats() async{

    var getBusData= await http.get(Uri.parse("http://localhost:8080/customer/api/viewSeats/${widget.busId}?date=2025-02-25"));
    var decodeSeat = jsonDecode(getBusData.body);

    setState(() {
      seats = List<Map<String, dynamic>> .from(decodeSeat);
    });

    print("The fetched data :  ${decodeSeat[0].seatNo}");
    
  }
  
  void toggleSeatSelection(int seatId) {
    setState(() {
      var seat = seats.firstWhere((seat) => seat['seatNo'] == seatId);
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

    // Show a loading dialog or indicator before sending requests
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Booking Seats"),
        content: CircularProgressIndicator(),
      ),
    );

    // Iterate over the selectedSeats array and send a POST request for each seat
    try {
      await Future.forEach(selectedSeats, (seatNo) async {
        final url = 'http://localhost:8080/customer/api/book-seat';
        final response = await http.post(
          Uri.parse(url),
          body: {
            'busId': widget.busId.toString(),
            'bookDate': widget.date,
            'seatNo': seatNo.toString(), // Sending one seat at a time
          },
        );

        // Handle the response for each seat
        if (response.statusCode == 200) {
          print("Seat $seatNo booked successfully.");
        } else {
          print("Failed to book seat $seatNo: ${response.body}");
        }
      });

      // After booking all seats, show a success message
      Navigator.of(context).pop(); // Close the loading dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Booking Successful"),
          content: Text("All selected seats have been booked successfully."),
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
    } catch (e) {
      // In case of any error
      Navigator.of(context).pop(); // Close the loading dialog
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
      print('Error: $e');
    }
    getSeats();
  }


  @override
  Widget build(BuildContext context) {
    return seats != null?
      Scaffold(
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
              'Bus ID: ${widget.busId}, Date: ${widget.date}, allseats:${seats.length}',
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
                    if (seats[index]['booked']) {
                      seatColor = Colors.red;
                    } else if (!seats[index]['booked']) {
                      seatColor = Colors.blue;
                    } else {
                      seatColor = Colors.red;
                    }

                    return GestureDetector(
                      onTap: (){
                        // print(seat['seatNo']);
                        // setState(() {
                        //   //toggleSeatSelection(seat['seatNo']);
                        //   seatColor=Colors.green;
                        // });
                        setState(() {
                          if(!seats[index]['booked']){
                            if (selectedSeats.contains(seat['seatNo'])) {
                              selectedSeats.remove(seat['seatNo']);
                            } else {
                              selectedSeats.add(seat['seatNo']);
                            }
                          }
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: selectedSeats.contains(seat['seatNo'])?
                                Colors.green:seatColor,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Center(child: Text("${seats[index]['seatNo']}",style: TextStyle(fontSize: 20,color: Colors.white),)),
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
    ):Center(child: CircularProgressIndicator(),);
  }
}
