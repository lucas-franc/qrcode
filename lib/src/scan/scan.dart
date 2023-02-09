import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodeScannerView extends StatefulWidget {
  const QrCodeScannerView({super.key});

  @override
  State<QrCodeScannerView> createState() => _QrCodeScannerViewState();
}

class _QrCodeScannerViewState extends State<QrCodeScannerView> {
  final MobileScannerController controller = MobileScannerController(
    torchEnabled: false,
  );

  String barcode = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 400,
              height: 400,
              child: MobileScanner(
                allowDuplicates: false,
                fit: BoxFit.contain,
                onDetect: (barcode, args) {
                  setState(() {
                    this.barcode = barcode.rawValue!;
                  });
                },
                controller: controller,
              ),
            ),
            Text(barcode),
          ],
        ),
      ),
    );
  }
}
