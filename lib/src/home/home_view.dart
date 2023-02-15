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
  final TextEditingController ocupationController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
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
              ),
              TextField(
                controller: ocupationController,
                decoration: const InputDecoration(
                  label: Text("Função"),
                ),
              ),
              TextField(
                controller: cpfController,
                decoration: const InputDecoration(
                  label: Text("CPF"),
                ),
              ),
              TextField(
                controller: statusController,
                decoration: const InputDecoration(
                  label: Text("Status"),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  errorFieldEmpty();
                },
                child: const Text('ok'),
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
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: nameController.text.toString(),
      DatabaseHelper.columnOcupation: nameController.text.toString(),
      DatabaseHelper.columnCpf: cpfController.text.toString(),
      DatabaseHelper.columnStatus: statusController.text.toString(),
    };
    await dbHelper.insert(row);
  }

  errorFieldEmpty() {
    if (nameController.text.isEmpty ||
        ocupationController.text.isEmpty ||
        statusController.text.isEmpty ||
        cpfController.text.isEmpty) {
      return;
    } else {
      _insert();
    }
  }
}
