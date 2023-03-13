import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:qrcode/src/database/database_helper.dart';
import 'package:qrcode/src/models/user.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({
    super.key,
  });

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final dbHelper = DatabaseHelper.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController ocupationController = TextEditingController();
  TextEditingController cpfController =
      MaskedTextController(mask: "000.000.000-00");
  TextEditingController phoneController =
      MaskedTextController(mask: "(55) 00 00000-0000");
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
                    label: Text("Cargo"),
                  ),
                ),
                TextField(
                  controller: cpfController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text("CPF"),
                  ),
                ),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text("Telefone"),
                  ),
                ),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
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

  void _verifyValues() {
    if (nameController.text.isNotEmpty &
        ocupationController.text.isNotEmpty &
        cpfController.text.isNotEmpty &
        phoneController.text.isNotEmpty &
        emailController.text.isNotEmpty &
        (selectedValue != null)) {
      _showDialog();
    } else {
      setState(() {
        emptyFieldError = "Preencha todos os campos!";
      });
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            content: SizedBox(
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nameController.text,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ocupationController.text,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    cpfController.text,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    phoneController.text,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    emailController.text,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    statusController.text,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ElevatedButton(
                onPressed: () {
                  _insert();
                  _clearValues();
                  Navigator.pop(context);
                },
                child: const Text("Confirmar cadastro"),
              ),
            ]);
      },
    );
  }

  void _insert() async {
    User user = User(
      name: nameController.text,
      ocupation: ocupationController.text,
      cpf: cpfController.text,
      phone: phoneController.text,
      email: emailController.text,
      status: selectedValue,
    );
    await dbHelper.insert(user.toMap());
  }

  void _clearValues() {
    nameController.clear();
    ocupationController.clear();
    cpfController.clear();
    phoneController.clear();
    emailController.clear();
    statusController.clear();
  }
}
