import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrisPage extends StatefulWidget {
  @override
  _QrisPageState createState() => _QrisPageState();
}

class _QrisPageState extends State<QrisPage> {
  MobileScannerController controller = MobileScannerController();

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  void _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QRIS'),
      ),
      body: MobileScanner(
        controller: controller,
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            debugPrint('Barcode found! ${barcode.rawValue}');
            // Implementasi logika ketika barcode ditemukan
          }
        },
      ),
    );
  }
}
