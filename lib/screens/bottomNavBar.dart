import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'homePage.dart';
import 'presenceScreen.dart';

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
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.teal,
                  ),
                  label: 'Accueil'),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.book,
                  color: Colors.teal,
                ),
                label: 'Presence',
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                    onPressed: () {
                      scanQRCode();
                    },
                    icon: const Icon(
                      Icons.qr_code,
                      color: Colors.teal,
                    )),
                label: 'QR code',
              ),
            ]),
      ),
    );
  }

  var getResult = 'QR Code Result';

  void scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      if (!mounted) return;

      setState(() {
        getResult = qrCode;
      });
      print("QRCode_Result:--");
      print(qrCode);
    } on PlatformException {
      getResult = 'Failed to scan QR Code.';
    }
  }
}
