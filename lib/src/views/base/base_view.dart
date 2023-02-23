import 'package:flutter/material.dart';
import 'package:qrcode/src/views/home/home_view.dart';
import 'package:qrcode/src/views/register/register_view.dart';
import 'package:qrcode/src/views/users_list/users_list_view.dart';

class BaseView extends StatefulWidget {
  const BaseView({super.key});

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Membros da Igreja'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.group),
              ),
              Tab(
                icon: Icon(Icons.app_registration),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            HomeView(),
            UsersListView(),
            RegisterView(),
          ],
        ),
      ),
    );
  }
}
