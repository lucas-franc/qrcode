import 'package:flutter/material.dart';
import 'package:qrcode/src/database/database_helper.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final dbHelper = DatabaseHelper.instance;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController functionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  label: Text("Nome"),
                ),
                onSubmitted: (value) {
                  setState(
                    () {
                      functionController.text.toString();
                    },
                  );
                },
              ),
              TextField(
                controller: functionController,
                decoration: const InputDecoration(
                  label: Text("Função"),
                ),
                onSubmitted: (value) {
                  setState(
                    () {
                      functionController.text.toString();
                    },
                  );
                },
              ),
              Text(
                nameController.text.toString(),
              ),
              Text(
                functionController.text.toString(),
              ),
              //Camera(),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.of(context).push(
              //       MaterialPageRoute(
              //         builder: (context) => const QrCodeScannerView(),
              //       ),
              //     );
              //   },
              //   child: const Text('SCAN'),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void _insert() async {
    // linha para incluir
    Map<String, dynamic> row = {};
    final id = await dbHelper.insert(row);
    print('linha inserida id: $id');
  }
}
