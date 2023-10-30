import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../login_screen.dart';
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

  List tabs = [
    HomePage(
      userConnect: userConnect,
    ),
    const PresenceScreen(),
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
                if (index != 2) {
                  _selectedIndex = index;
                }
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

  var getResult = '';

  void scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      if (!mounted) return;

      setState(() {
        getResult = qrCode;
      });
      if (getResult.isNotEmpty &&
          getResult != "-1" &&
          int.tryParse(getResult) != -1 &&
          getResult != "") {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              content: SizedBox(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check,
                      size: 100,
                      color: Colors.teal,
                    ),
                    Text(
                      "Le code QR a été numérisé avec succès.",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
      print("QRCode_Result:--");
      print(qrCode);
    } on PlatformException {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: SizedBox(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.close,
                    size: 100,
                    color: Colors.red,
                  ),
                  Text(
                    "Échec de la numérisation du code QR.",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          );
        },
      );

      /* Échec de la numérisation du code QR */
      getResult = 'Failed to scan QR Code.';
    }
  }
}
