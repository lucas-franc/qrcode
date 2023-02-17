import 'package:flutter/material.dart';
import 'package:qrcode/src/database/database_helper.dart';
import 'package:qrcode/src/models/user.dart';

class UsersView extends StatefulWidget {
  const UsersView({super.key});

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  DatabaseHelper db = DatabaseHelper.instance;
  List<User> users = [];
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Membros"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return listUsers(context, index);
            },
          ),
        ),
      ),
    );
  }

  listUsers(BuildContext context, int index) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              users[index].name ?? "",
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Visibility(
            visible: users[index].status == "Ativo",
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
    );
  }
}
