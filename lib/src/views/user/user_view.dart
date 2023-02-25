import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode/src/database/database_helper.dart';
import 'package:qrcode/src/models/user.dart';
import 'package:share_plus/share_plus.dart';

class UserView extends StatefulWidget {
  final User user;
  const UserView({super.key, required this.user});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  DatabaseHelper db = DatabaseHelper.instance;
  User user = User();
  int? id;
  String? name;
  String? ocupation;
  String? cpf;
  String? phone;
  String? email;
  String? status;
  QrImage? qrImage;

  GlobalKey globalKey = GlobalKey();
  String data = "";
  @override
  void initState() {
    super.initState();

    user = User.fromMap(widget.user.toMap());
    setState(() {
      name = user.name;
      ocupation = user.ocupation;
      cpf = user.cpf;
      phone = user.phone;
      email = user.email;
      status = user.status;
      data = user.id.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Membros"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nome',
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 18),
                        ),
                        Text(
                          name.toString(),
                          style: const TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 32,
                    ),
                    Column(
                      children: [
                        const Text(
                          'Ocupação',
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 18),
                        ),
                        Text(
                          ocupation.toString(),
                          style: const TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CPF',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 18),
                    ),
                    Text(
                      cpf.toString(),
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Email',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 18),
                    ),
                    Text(
                      email.toString(),
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Telefone',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 18),
                    ),
                    Text(
                      phone.toString(),
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Status',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 18),
                    ),
                    Text(
                      status.toString(),
                      style: const TextStyle(fontSize: 24),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Center(
                    child: RepaintBoundary(
                      key: globalKey,
                      child: QrImage(
                        data: user.id.toString(),
                        size: 250.0,
                        version: QrVersions.auto,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      var file = await _capturePng();
                      Share.shareXFiles([XFile(file.path)]);
                    },
                    child: const Text(
                      "Compartilhar QRCode",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<File> _capturePng() async {
    final RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage();
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final file = await File('${tempDir.path}/image.png').create();
    await file.writeAsBytes(pngBytes);
    return file;
  }
}
