import 'package:flutter/material.dart';
import 'package:qrcode/src/database/database_helper.dart';
import 'package:qrcode/src/models/user.dart';

class UserDeleteView extends StatefulWidget {
  final User user;
  const UserDeleteView({super.key, required this.user});

  @override
  State<UserDeleteView> createState() => _UserDeleteViewState();
}

class _UserDeleteViewState extends State<UserDeleteView> {
  DatabaseHelper db = DatabaseHelper.instance;
  User user = User();
  String text = "Tem certeza que deseja excluir este membro?";
  Color? color;
  Color? textColor;
  @override
  void initState() {
    super.initState();

    user = User.fromMap(
      widget.user.toMap(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: color,
                ),
                child: Text(
                  text,
                  style: TextStyle(fontSize: 20, color: textColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _delete();
                        Navigator.pop(
                          context,
                          user.id,
                        );
                      },
                      child: const Text(
                        "Sim",
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.pop(
                          context,
                        );
                      },
                      child: const Text(
                        "Não",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _delete() async {
    await db.delete(user.id!);
  }
}
