import 'package:flutter/material.dart';
import 'package:qrcode/src/database/database_helper.dart';
import 'package:qrcode/src/models/user.dart';
import 'package:qrcode/src/views/user/user_view.dart';

class UsersListView extends StatefulWidget {
  final int? userDeleteId;
  const UsersListView({super.key, this.userDeleteId});

  @override
  State<UsersListView> createState() => UsersListViewState();
}

class UsersListViewState extends State<UsersListView> {
  DatabaseHelper db = DatabaseHelper.instance;
  List<User> users = [];

  int? result;
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
    return GestureDetector(
      onTap: () async {
        final userId = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserView(
              user: users[index],
            ),
          ),
        );
        var $users = List<User>.from(users);
        final user = $users.firstWhere((user) => user.id == userId);
        $users.remove(user);
        setState(() {
          users = $users;
        });
      },
      child: Card(
        color: Colors.grey.shade100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                top: 32,
                bottom: 32,
              ),
              child: Text(
                users[index].name ?? "",
                style: const TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}
