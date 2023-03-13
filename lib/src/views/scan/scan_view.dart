import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qrcode/src/database/database_helper.dart';
import 'package:qrcode/src/models/user.dart';

class QrCodeScannerView extends StatefulWidget {
  const QrCodeScannerView({super.key});

  @override
  State<QrCodeScannerView> createState() => _QrCodeScannerViewState();
}

class _QrCodeScannerViewState extends State<QrCodeScannerView> {
  final MobileScannerController controller = MobileScannerController(
    torchEnabled: false,
  );
  DatabaseHelper db = DatabaseHelper.instance;
  List usersId = [];
  List<User> users = [];
  @override
  void initState() {
    super.initState();

    db.queryAllRows().then((list) {
      setState(() {
        users = list;
      });
    });

    //asynchronous delay
  }

  String? name;
  String resultText = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width,
              height: 400,
              child: MobileScanner(
                allowDuplicates: false,
                fit: BoxFit.cover,
                onDetect: (barcode, args) {
                  for (var user in users) {
                    if (user.id.toString() == barcode.rawValue) {
                      if (user.status == "Ativo") {
                        setState(() {
                          resultText = "Membro ativo";
                          name = user.name;
                        });
                      } else {
                        setState(() {
                          resultText = "Membro desativado";
                          name = user.name;
                        });
                      }
                      return;
                    }
                  }
                },
                controller: controller,
              ),
            ),
            Visibility(
              visible: resultText == "Membro ativo",
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: const Icon(
                        Icons.done,
                        size: 72,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        name.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: resultText == "Membro desativado",
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 72,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        name.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
