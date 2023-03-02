import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrcode/src/database/database_helper.dart';
import 'package:share_plus/share_plus.dart';

class DataCopyView extends StatefulWidget {
  const DataCopyView({super.key});

  @override
  State<DataCopyView> createState() => _DataCopyViewState();
}

class _DataCopyViewState extends State<DataCopyView> {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  String message = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(message),
            ElevatedButton(
              onPressed: () async {
                databaseHelper.close().then(
                  (value) {
                    copyDatabase();
                  },
                );
              },
              child: const Text('Copiar dados'),
            ),
            ElevatedButton(
              onPressed: () async {
                var file = await copyDatabase();
                Share.shareXFiles(
                  [
                    XFile(file),
                  ],
                );
              },
              child: const Text(
                'Compartilhar dados',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> copyDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "users.db");
    String newPath = "/storage/emulated/0/Download/users.db";
    File databaseCopy = await File(path).copy(newPath);
    String fileCopy = databaseCopy.path;
    return fileCopy;
  }
}
