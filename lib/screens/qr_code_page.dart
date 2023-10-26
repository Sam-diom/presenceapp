import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QrCodeScannePage extends StatefulWidget {
  const QrCodeScannePage({super.key});

  @override
  State<QrCodeScannePage> createState() => _QrCodeScannePageState();
}

class _QrCodeScannePageState extends State<QrCodeScannePage> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scanQRCode();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
