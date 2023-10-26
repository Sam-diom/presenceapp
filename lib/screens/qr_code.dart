import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:presenceapp/screens/homePage.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

MobileScannerController cameraController = MobileScannerController();

const bgColor = Color(0xfffafafa);

class QrCodePage extends StatefulWidget {
  const QrCodePage({super.key});

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  bool isScanCompleted = false;
  bool isFlashOn = false;
  bool isFontCamera = false;
  void closeScreenn() {
    isScanCompleted = false;
  }

  var getResult = 'QR Code Result';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      /* appBar: AppBar(
        title: const Text(
          'Mobile Scanner',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.black,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ) ,*/
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Place the QR code in the area',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Scanning will be started automatically",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                )
              ],
            ),
          ),
          Expanded(flex: 4, child: Text(getResult)),
          const SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
            onPressed: () {
              scanQRCode();
            },
            child: const Text(
              'Scanner',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                letterSpacing: 1,
              ),
            ),
          )
        ]),
      ),
    );
  }

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
