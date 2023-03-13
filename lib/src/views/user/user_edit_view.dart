import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:qrcode/src/database/database_helper.dart';
import 'package:qrcode/src/models/user.dart';

class UserEditView extends StatefulWidget {
  final User user;
  const UserEditView({super.key, required this.user});

  @override
  State<UserEditView> createState() => _UserEditViewState();
}

class _UserEditViewState extends State<UserEditView> {
  DatabaseHelper db = DatabaseHelper.instance;
  User user = User();

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
  GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    user = User.fromMap(
      widget.user.toMap(),
    );
    setState(() {
      ocupationController.text = user.ocupation.toString();
      phoneController.text = user.phone.toString();
      emailController.text = user.email.toString();
      nameController.text = user.name.toString();
      cpfController.text = user.cpf.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Editar"),
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
                    hintText: ("(55) 00 00000-0000"),
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
                    'Editar usuário',
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
        cpfController.text.isNotEmpty &
        ocupationController.text.isNotEmpty &
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

  void _update() async {
    User userEdit = User(
      id: user.id,
      name: nameController.text,
      ocupation: ocupationController.text,
      cpf: cpfController.text,
      phone: phoneController.text,
      email: emailController.text,
      status: selectedValue,
    );
    await db.update(userEdit);
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
                  user.name.toString(),
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
                  user.cpf.toString(),
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Usuário editado com sucesso",
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
                _update();
                Navigator.pop(context);
              },
              child: const Text("Confirmar edição"),
            ),
          ],
        );
      },
    );
  }
}
