import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:qrcode/src/database/database_helper.dart';
import 'package:qrcode/src/models/user.dart';
import 'package:qrcode/src/users/users_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final dbHelper = DatabaseHelper.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController ocupationController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  final List<String> items = [
    'Ativo',
    'Inativo',
  ];
  String? selectedValue;
  String emptyFieldError = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Cadastro"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    label: Text("Nome"),
                  ),
                ),
                TextField(
                  controller: ocupationController,
                  decoration: const InputDecoration(
                    label: Text("Função"),
                  ),
                ),
                TextField(
                  controller: cpfController,
                  decoration: const InputDecoration(
                    label: Text("CPF"),
                  ),
                ),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    label: Text("Phone"),
                  ),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    label: Text("Email"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      searchController: statusController,
                      hint: Text(
                        'Status',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: items
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value as String;
                        });
                      },
                      buttonHeight: 40,
                      buttonWidth: 140,
                      itemHeight: 40,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _verifyValues();
                  },
                  child: const Text(
                    'Cadastrar usuário',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Text(
                  emptyFieldError,
                  style: const TextStyle(color: Colors.redAccent, fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _insert() async {
    User user = User(
      name: nameController.text.toString(),
      ocupation: ocupationController.text.toString(),
      cpf: cpfController.text.toString(),
      phone: phoneController.text.toString(),
      email: emailController.text.toString(),
      status: selectedValue,
    );
    await dbHelper.insert(user.toMap());
  }

  _verifyValues() {
    if (nameController.text.isNotEmpty &
        ocupationController.text.isNotEmpty &
        cpfController.text.isNotEmpty &
        phoneController.text.isNotEmpty &
        emailController.text.isNotEmpty &
        (selectedValue != null)) {
      _insert();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const UsersView(),
        ),
      );
    } else {
      setState(() {
        emptyFieldError = "Preencha todos os campos!";
      });
    }
  }
}
