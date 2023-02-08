import 'package:flutter/material.dart';
import 'package:qrcode/src/camera/camera.dart';
import 'package:qrcode/src/scan/scan.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            children: [
              const Camera(),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const QrCodeScannerView(),
                    ),
                  );
                },
                child: const Text('SCAN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
