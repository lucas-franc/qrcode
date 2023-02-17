import 'package:flutter/material.dart';
import 'package:qrcode/src/database/database_helper.dart';
import 'package:qrcode/src/models/user.dart';
import 'package:qrcode/src/views/register/register_view.dart';
import 'package:qrcode/src/views/users/users_view.dart';

class RegisterConfirmationView extends StatefulWidget {
  final String? name;
  final String? ocupation;
  final String? cpf;
  final String? phone;
  final String? email;
  final String? status;
  const RegisterConfirmationView(
      {super.key,
      required this.name,
      required this.ocupation,
      required this.cpf,
      required this.phone,
      required this.email,
      required this.status});

  @override
  State<RegisterConfirmationView> createState() =>
      _RegisterConfirmationViewState();
}

class _RegisterConfirmationViewState extends State<RegisterConfirmationView> {
  DatabaseHelper db = DatabaseHelper.instance;
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                          color: Colors.black54,
                          blurRadius: 1.5,
                          spreadRadius: 0.1,
                          offset: Offset(0.0, 0.75))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          widget.name.toString(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          widget.ocupation.toString(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          widget.cpf.toString(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          widget.phone.toString(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          widget.email.toString(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Text(
                              widget.status.toString(),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Visibility(
                              visible: widget.status == "Ativo",
                              replacement: Container(
                                margin: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                width: 24,
                                height: 24,
                              ),
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.lightGreen,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                width: 24,
                                height: 24,
                              ),
                            )
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _insert();
                            Navigator.pop(context);
                          });
                        },
                        child: const Text(
                          'Confirmar cadastro',
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _insert() async {
    User user = User(
      name: widget.name,
      ocupation: widget.ocupation,
      cpf: widget.cpf,
      phone: widget.phone,
      email: widget.email,
      status: widget.status,
    );
    await dbHelper.insert(user.toMap());
  }
}
