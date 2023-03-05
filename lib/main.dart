import 'package:flutter/material.dart';
import 'package:qrcode/src/shared/themes/color_schemes.g.dart';
import 'package:qrcode/src/views/base/base_view.dart';
import 'package:qrcode/src/views/users_list/users_list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const BaseView(),
        '/list': (context) => const UsersListView(),
      },
      debugShowCheckedModeBanner: false,
      title: 'QRCode',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        colorScheme: lightColorScheme,
      ),
    );
  }
}
