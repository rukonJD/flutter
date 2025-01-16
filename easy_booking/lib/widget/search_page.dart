import 'dart:convert';  // For JSON encoding/decoding
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // For date formatting
import 'bus_list.dart'; // Import the BusListPage

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _UIEX03FtState createState() => _UIEX03FtState();
}

class _UIEX03FtState extends State<SearchPage> {
  bool isLoading = false;

  // Initialize the selected source and destination to null
  String? selectedSource;
  String? selectedDestination;
  String? selectedDate;

  final TextEditingController dateController = TextEditingController();

  // List of sample sources and destinations (you can replace this with actual data)
  List<String> sources = ['Gabtoli', 'Mirpur', 'Chicago', 'San Francisco'];
  List<String> destinations = ['Potuakali', 'Feni', 'Dallas', 'Boston'];

  // Function to fetch bus data from the API
  Future<void> fetchBusData(String source, String destination, String date) async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse('http://localhost:8080/customer/api/search-bus?source=$source&destination=$destination&date=$date');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Check if the response is a list of buses
        if (data is List) {
          setState(() {
            isLoading = false;
          });

          // Navigate to the bus list page and pass the bus data
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BusListPage(busResults: data), // Pass the data
            ),
          );
        } else {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: Expected a list of buses')),
          );
        }
      } else {
        setState(() {
          isLoading = false;
        });
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

  // Function to open the date picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ) ?? currentDate;

    // Format the selected date and update the controller
    setState(() {
      dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffd44d57),
        title: Text("Easy Booking", style: TextStyle(color: Colors.white)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top banner section
            Container(
              width: w,
              height: 320,
              decoration: BoxDecoration(
                color: Color(0xffd44d57),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bus Tickets",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 28,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Search for buses easily by entering your trip details.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30),

            // Bus search form section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  // Source Dropdown
                  DropdownButtonFormField<String>(
                    value: selectedSource,
                    decoration: InputDecoration(
                      labelText: 'Source',
                      prefixIcon: Icon(Icons.location_on),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.black26,
                    ),
                    items: sources.map((source) {
                      return DropdownMenuItem<String>(
                        value: source,
                        child: Text(source),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSource = value;
                      });
                    },
                    hint: Text('Select source '),
                  ),
                  SizedBox(height: 20),

                  // Destination Dropdown
                  DropdownButtonFormField<String>(
                    value: selectedDestination,
                    decoration: InputDecoration(
                      labelText: 'Destination',
                      prefixIcon: Icon(Icons.location_on),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.black26,
                    ),
                    items: destinations.map((destination) {
                      return DropdownMenuItem<String>(
                        value: destination,
                        child: Text(destination),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDestination = value;
                      });
                    },
                    hint: Text('Select destination '),
                  ),
                  SizedBox(height: 20),

                  // Date Input Field with Date Picker
                  TextField(
                    controller: dateController,
                    readOnly: true, // Make the field read-only
                    decoration: InputDecoration(
                      labelText: 'Date',
                      hintText: 'YYYY-MM-DD',
                      prefixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.black26,
                    ),
                    onTap: () => _selectDate(context), // Open the date picker when tapped
                  ),
                  SizedBox(height: 30),

                  // Search Button
                  ElevatedButton(
                    onPressed: () {
                      String source = selectedSource ?? '';
                      String destination = selectedDestination ?? '';
                      String date = dateController.text;

                      if (source.isNotEmpty && destination.isNotEmpty && date.isNotEmpty) {
                        fetchBusData(source, destination, date);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please fill all fields")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16,horizontal: 50), backgroundColor: Color(0xffd44d57),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Search',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),

                  // Loading indicator
                  if (isLoading) ...[
                    SizedBox(height: 20),
                    Center(child: CircularProgressIndicator()),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
