import 'package:aqua_nav_bar/aqua_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:singup/login/loginPage.dart';
import 'package:singup/main.dart';
import 'package:singup/profile/profile.dart';
import 'package:singup/settings/settings.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _navPages = [const Loginpage(), const SettingsPage(), const ProfilePage()];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: AquaNavBar(
        currentIndex: currentIndex,
        textSize: 15.0,
        textColor: Colors.grey,
        activeColor: Colors.blueAccent,
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        barItems: [
          // First tab item (Home)
          BarItem(
            title: "Home",
            icon: const Icon(
              Icons.home,
              size: 30.0,
            ),
          ),
          // Second tab item (Settings)
          BarItem(
            title: "Settings",
            icon: const Icon(
              Icons.settings,
              size: 30.0,
            ),
          ),
          // Third tab item (Profile)
          BarItem(
            title: "Profile",
            icon: const Icon(
              Icons.person,
              size: 30.0,
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: _navPages[currentIndex],
      ),
    );
  }
}



