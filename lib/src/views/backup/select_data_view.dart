import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrcode/src/database/database_helper.dart';

class SelectDataView extends StatefulWidget {
  const SelectDataView({super.key});

  @override
  State<SelectDataView> createState() => _SelectDataViewState();
}

class _SelectDataViewState extends State<SelectDataView> {
  DatabaseHelper dbHelper = DatabaseHelper.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                dbHelper.close().then((value) => selectDatabaseCopy());
              },
              child: const Text(
                'Selecionar arquivo',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<File> selectDatabaseCopy() async {
    FilePickerResult? resultPath = await FilePicker.platform.pickFiles();
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "users.db");
    File newDatabase = await File(resultPath!.files.first.path!).copy(path);
    print(newDatabase.path);

    return newDatabase;
  }
}
