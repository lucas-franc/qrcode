import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrcode/src/database/database_helper.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';

class DataCopyView extends StatefulWidget {
  const DataCopyView({super.key});

  @override
  State<DataCopyView> createState() => _DataCopyViewState();
}

class _DataCopyViewState extends State<DataCopyView> {
  DatabaseHelper db = DatabaseHelper.instance;
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
              onPressed: () async {},
              child: const Text('Copy DB'),
            ),
          ],
        ),
      ),
    );
  }
}
