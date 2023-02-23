import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode/src/database/database_helper.dart';
import 'package:qrcode/src/models/user.dart';
import 'package:social_share/social_share.dart';

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
      qrImage = QrImage(
        data: user.id.toString(),
        size: 240,
      );
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
                  child: Center(child: qrImage),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Compartilhar QRCode",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
