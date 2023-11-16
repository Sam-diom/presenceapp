import 'package:flutter/material.dart';
import 'package:inTime/screens/homePage.dart';
import 'package:inTime/screens/presenceScreen.dart';

class BottomNavBar extends StatefulWidget {
  static const String id = 'navBar';

  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  List<Widget> tabs = [
    HomePage(userConnect: ''),
    PresenceScreen(),
    PresenceScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        height: 90,
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
              label: 'Accueil',
            ),
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
          ],
        ),
      ),
      body: tabs[_selectedIndex],
    );
  }
}
