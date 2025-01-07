import 'dart:convert';  // For JSON encoding/decoding
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UIEX03Ft extends StatefulWidget {
  const UIEX03Ft({Key? key}) : super(key: key);

  @override
  _UIEX03FtState createState() => _UIEX03FtState();
}

class _UIEX03FtState extends State<UIEX03Ft> {
  // Data to store the bus search results
  List<dynamic> busResults = [];
  bool isLoading = false;

  final TextEditingController sourceController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  // Focus nodes for better focus management
  final FocusNode sourceFocusNode = FocusNode();
  final FocusNode destinationFocusNode = FocusNode();
  final FocusNode dateFocusNode = FocusNode();

  // Function to fetch bus data from the API
  Future<void> fetchBusData(String source, String destination, String date) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse('http://localhost:8080/customer/api/search-bus?source=$source&destination=$destination&date=$date');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Print the response body to debug
        print('Response body: ${response.body}');
        final data = json.decode(response.body);  // Decode the response

        // Now assume the response is a list of buses directly, not an object with "bus_list"
        if (data is List) {
          setState(() {
            busResults = data;  // Directly use the list if it's a list of buses
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          print('Error: Expected a list of buses');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('API response is invalid: Expected a list')),
          );
        }
      } else {
        setState(() {
          isLoading = false;
        });
        print('Failed to load bus data');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load bus data')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error occurred while fetching data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred while fetching data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffd44d57),
        title: Text("Bus Tickets", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(  // Wrap the entire body in a scroll view to prevent overflow
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  child: Container(
                    color: Color(0xffd44d57),
                    height: 388,
                    width: w,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: 10,
                          top: 20,
                          child: Text(
                            "Bus tickets",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 22),
                          ),
                        ),
                        Positioned(
                          top: 70,
                          child: Center(
                            child: Container(
                              alignment: Alignment.center,
                              width: w - 20,
                              height: 300,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(  // Use a Column to hold the input fields and button
                                children: [
                                  // Source TextField
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: sourceController,
                                      focusNode: sourceFocusNode,
                                      decoration: InputDecoration(
                                        labelText: 'Enter Source',
                                        border: OutlineInputBorder(),
                                      ),
                                      onTap: () {
                                        FocusScope.of(context).requestFocus(sourceFocusNode);
                                      },
                                    ),
                                  ),
                                  // Destination TextField
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: destinationController,
                                      focusNode: destinationFocusNode,
                                      decoration: InputDecoration(
                                        labelText: 'Enter Destination',
                                        border: OutlineInputBorder(),
                                      ),
                                      onTap: () {
                                        FocusScope.of(context).requestFocus(destinationFocusNode);
                                      },
                                    ),
                                  ),
                                  // Date TextField
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: dateController,
                                      focusNode: dateFocusNode,
                                      decoration: InputDecoration(
                                        labelText: 'Enter Date (YYYY-MM-DD)',
                                        border: OutlineInputBorder(),
                                      ),
                                      onTap: () {
                                        FocusScope.of(context).requestFocus(dateFocusNode);
                                      },
                                    ),
                                  ),
                                  // Search Button
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        String source = sourceController.text;
                                        String destination = destinationController.text;
                                        String date = dateController.text;

                                        if (source.isNotEmpty && destination.isNotEmpty && date.isNotEmpty) {
                                          fetchBusData(source, destination, date);
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text("Please fill all fields"))
                                          );
                                        }
                                      },
                                      child: Text('Search'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (isLoading)
              Center(child: CircularProgressIndicator())
            else
            // Make the ListView scrollable
              Container(
                height: 300,  // Set a fixed height for the list view
                child: ListView.builder(
                  itemCount: busResults.length,
                  itemBuilder: (context, index) {
                    var bus = busResults[index];
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text("Bus Name: ${bus['busNo']}"),
                        subtitle: Text("Departure: ${bus['arrivalDate']}"),
                        trailing: Text("Fare: ${bus['price']}"),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
