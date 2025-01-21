import 'dart:convert';

import 'package:easy_booking/widget/ticket_booking.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SelectSeat extends StatefulWidget {
  final int busId;
  final String date;
  final int fare;
  final String operator;
  final List allseats;


  const SelectSeat({
    Key? key,
    required this.busId,
    required this.date,
    required this.fare,
    required this.allseats,
    required this.operator
  }) : super(key: key);

  @override
  _RedBusSeatUIState createState() => _RedBusSeatUIState();
}

class _RedBusSeatUIState extends State<SelectSeat> {
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
 // Function to navigate to the TicketBookPage
  void navigateToTicketBooking() {
    if (selectedSeats.isEmpty) {
      // Show alert if no seats are selected
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("No Seats Selected"),
          content: Text("Please select at least one seat to proceed."),
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
      // Calculate total fare based on the number of selected seats
      double fare = widget.fare as double;  // Replace with dynamic fare based on your logic
      double totalFare = fare * selectedSeats.length;

      // Navigate to TicketBookPage with selected seats, busId, and userId
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TicketBookPage(
            selectedSeats: selectedSeats,
            busId: widget.busId,
            userId: 5001, // Replace with actual user ID (you can fetch it from a login state or pass it dynamically)
            totalFare: totalFare,
            noOfSeats: selectedSeats.length,
            fare: widget.fare,
              bookSeats: bookSeats,
            operator: widget.operator,
          ),
        ),
      );
    }
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

      // // After booking all seats, show a success message
      // Navigator.of(context).pop(); // Close the loading dialog
      // showDialog(
      //   context: context,
      //   builder: (context) => AlertDialog(
      //     title: Text("Booking Successful"),
      //     content: Text("All selected seats have been booked successfully."),
      //     actions: [
      //       TextButton(
      //         onPressed: () {
      //           Navigator.of(context).pop();
      //         },
      //         child: Text("OK"),
      //       ),
      //     ],
      //   ),
      // );
    } catch (e) {
      // In case of any error
      // Navigator.of(context).pop(); // Close the loading dialog
      // showDialog(
      //   context: context,
      //   builder: (context) => AlertDialog(
      //     title: Text("Booking Failed"),
      //     content: Text("There was an issue with your booking. Please try again."),
      //     actions: [
      //       TextButton(
      //         onPressed: () {
      //           Navigator.of(context).pop();
      //         },
      //         child: Text("OK"),
      //       ),
      //     ],
      //   ),
      // );
      print('Error: $e');
    }
    getSeats();
  }


  // Future<void> handleBooking() async {
  //   if (selectedSeats.isEmpty) {
  //     // If no seats are selected, show a warning message
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: Text("No Seats Selected"),
  //         content: Text("Please select at least one seat to proceed."),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text("OK"),
  //           ),
  //         ],
  //       ),
  //     );
  //     return; // Exit if no seats are selected
  //   }
  //
  //   // Calculate total fare based on the selected seats
  //   double totalFare = (widget.fare * selectedSeats.length) as double;
  //
  //   // Show a loading dialog or indicator before proceeding with booking
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: Text("Booking Seats"),
  //       content: CircularProgressIndicator(),
  //     ),
  //   );
  //
  //   try {
  //     // Send a POST request for each selected seat
  //     await Future.forEach(selectedSeats, (seatNo) async {
  //       final url = 'http://localhost:8080/customer/api/book-seat';
  //       final response = await http.post(
  //         Uri.parse(url),
  //         body: {
  //           'busId': widget.busId.toString(),
  //           'bookDate': widget.date,
  //           'seatNo': seatNo.toString(),
  //         },
  //       );
  //
  //       // Handle the response for each seat
  //       if (response.statusCode == 200) {
  //         print("Seat $seatNo booked successfully.");
  //       } else {
  //         print("Failed to book seat $seatNo: ${response.body}");
  //       }
  //     });
  //
  //     // Close the loading dialog
  //     Navigator.of(context).pop();
  //
  //     // Show a success message after booking
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: Text("Booking Successful"),
  //         content: Text("All selected seats have been booked successfully."),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               // After successful booking, navigate to the TicketBookPage
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => TicketBookPage(
  //                     selectedSeats: selectedSeats,
  //                     busId: widget.busId,
  //                     userId: 5001, // Replace with actual user ID (you can fetch it dynamically)
  //                     totalFare: totalFare,
  //                     noOfSeats: selectedSeats.length,
  //                     fare: widget.fare,
  //                   ),
  //                 ),
  //               );
  //             },
  //             child: Text("OK"),
  //           ),
  //         ],
  //       ),
  //     );
  //   } catch (e) {
  //     // In case of an error, show an error message
  //     Navigator.of(context).pop(); // Close the loading dialog
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: Text("Booking Failed"),
  //         content: Text("There was an issue with your booking. Please try again."),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text("OK"),
  //           ),
  //         ],
  //       ),
  //     );
  //     print('Error: $e');
  //   }
  //
  //   // Refresh the seat list after booking
  //   getSeats();
  // }



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
              onPressed: navigateToTicketBooking, // Call bookSeats function
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
