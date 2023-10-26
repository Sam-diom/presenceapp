import 'package:flutter/material.dart';

import 'homePage.dart';
import 'presenceScreen.dart';
import 'qr_code_page.dart';

class BottomNavBar extends StatefulWidget {
  static const String id = 'navBar';
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  List tabs = const [
    HomePage(userConnect: ''),
    PresenceScreen(),
    QrCodeScannePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_selectedIndex],
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
        ),
        child: BottomNavigationBar(
            selectedItemColor: Colors.teal,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            elevation: 20,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.teal,
                  ),
                  label: 'Accueil'),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.book,
                  color: Colors.teal,
                ),
                label: 'Presence',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.qr_code,
                  color: Colors.teal,
                ),
                label: 'QR code',
              ),
            ]),
      ),
    );
  }
}
