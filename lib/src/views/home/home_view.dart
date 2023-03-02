import 'package:flutter/material.dart';
import 'package:qrcode/src/shared/container_action.dart';
import 'package:qrcode/src/views/backup/data_copy_view.dart';
import 'package:qrcode/src/views/backup/select_data_view.dart';
import 'package:qrcode/src/views/scan/scan_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width,
              ),
              ContainerAction(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QrCodeScannerView(),
                    ),
                  );
                },
                text: "Ler QR Code",
                icon: Icons.qr_code_scanner,
              ),
              ContainerAction(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DataCopyView(),
                    ),
                  );
                },
                text: "Fazer backup",
                icon: Icons.cloud_download_outlined,
              ),
              ContainerAction(
                icon: Icons.cloud_upload_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelectDataView(),
                    ),
                  );
                },
                text: "Escolher backup",
              )
            ],
          ),
        ),
      ),
    );
  }
}
