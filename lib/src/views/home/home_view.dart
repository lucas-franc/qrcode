import 'package:flutter/material.dart';
import 'package:qrcode/src/views/backup/data_copy_view.dart';
import 'package:qrcode/src/views/scan/scan_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QrCodeScannerView(),
                    ),
                  );
                },
                child: const Text("Ler QRCode"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DataCopyView(),
                    ),
                  );
                },
                child: const Text("Fazer cópia dos membros"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
