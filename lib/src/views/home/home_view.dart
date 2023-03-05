import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrcode/src/database/database_helper.dart';
import 'package:qrcode/src/models/user.dart';
import 'package:qrcode/src/views/scan/scan_view.dart';
import 'package:share_plus/share_plus.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  DatabaseHelper db = DatabaseHelper.instance;
  List<User> users = [];
  SnackBar backupDone = const SnackBar(content: Text("Concluído"));
  @override
  void initState() {
    super.initState();

    db.queryAllRows().then((list) {
      setState(() {
        users = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 48),
                  child: Column(
                    children: [
                      SizedBox(
                        width: size.width,
                      ),
                      const Text(
                        "Membros cadastrados",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        users.length.toString(),
                        style: const TextStyle(
                          fontSize: 124,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QrCodeScannerView(),
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'LER QRCODE',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: ElevatedButton(
                        onPressed: () async {
                          db.close().then(
                            (value) {
                              copyDatabase();
                              final snackBar = SnackBar(
                                content: const Text('Backup feito com sucesso'),
                                action: SnackBarAction(
                                  label: 'Fechar',
                                  onPressed: () {},
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'FAZER BACKUP',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: ElevatedButton(
                        onPressed: () async {
                          var file = await copyDatabase();

                          Share.shareXFiles(
                            [
                              XFile(file),
                            ],
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'COMPARTILHAR BACKUP',
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        db.close().then((value) {
                          selectDatabaseCopy();
                          final snackBar = SnackBar(
                            content: const Text('Backup restaurado'),
                            action: SnackBarAction(
                              label: 'Fechar',
                              onPressed: () {},
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          'RESTAURAR BACKUP',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<File?> selectDatabaseCopy() async {
    FilePickerResult? resultPath = await FilePicker.platform.pickFiles();
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "users.db");
    File? newDatabase;
    if (resultPath != null) {
      newDatabase = await File(resultPath.files.first.path!).copy(path);
    } else {
      debugPrint("error");
    }

    return newDatabase;
  }

  Future<String> copyDatabase() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kkmm-yyyy-MM-dd').format(now);
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "users.db");
    String newPath = "/storage/emulated/0/Download/users$formattedDate.db";
    File databaseCopy = await File(path).copy(newPath);

    String fileCopy = databaseCopy.path;
    return fileCopy;
  }
}
