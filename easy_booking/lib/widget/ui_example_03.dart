import 'package:flutter/material.dart';

import 'package:easy_booking/widget/dismissible_flutter.dart';
import 'package:easy_booking/widget/ui_example_03-a.dart';

import 'list_grid.dart';

class Bottom_Nav_Redbus extends StatefulWidget {
  const Bottom_Nav_Redbus({Key? key}) : super(key: key);

  @override
  State<Bottom_Nav_Redbus> createState() => _Bottom_NavState();
}

class _Bottom_NavState extends State<Bottom_Nav_Redbus> {
  int selectedIndex = 0;
  PageController pageController = PageController();

  void onTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          UIEX03Ft(),
          Dismissible_Widget(),
          List_Grid(),
          List_Grid(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: "Bookings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: "Help",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "My Account",
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Color(0xffd44d57),
        unselectedItemColor: Colors.grey,
        onTap: onTapped,
      ),
    );
  }
}
