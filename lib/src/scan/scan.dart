import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodeScannerView extends StatefulWidget {
  const QrCodeScannerView({super.key});

  @override
  State<QrCodeScannerView> createState() => _QrCodeScannerViewState();
}

class _QrCodeScannerViewState extends State<QrCodeScannerView> {
  final MobileScannerController controller = MobileScannerController(
    torchEnabled: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: MobileScanner(
                allowDuplicates: false,
                fit: BoxFit.contain,
                onDetect: (barcode, args) {
                  setState(() {
                    // ignore: avoid_print
                    print(barcode.rawValue);
                  });
                },
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
