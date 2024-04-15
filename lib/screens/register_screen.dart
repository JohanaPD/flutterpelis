// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:peliculas_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';

class RecordScreen extends StatefulWidget {
  final User? editUser;
  const RecordScreen({super.key, this.editUser});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myRecord = GlobalKey<FormState>();

    final inputUserController = TextEditingController();
    final inputPassController = TextEditingController();
    final repeatPassController = TextEditingController();
    // final Map<String, String> valuesInput = {
    //   'NickName': 'prueba',
    //   'password1': '123456',
    //   'password2': '123456'
    // };
    // ignore: unused_local_variable

    @override
    void initState() {
      if (widget.editUser != null) {
        inputUserController.text = widget.editUser!.usuario;
        inputPassController.text =
            // ignore: unnecessary_null_comparison, prefer_if_null_operators
            widget.editUser!.passw != null ? widget.editUser!.passw : '';
        // __repeatPassController.text =
        //     widget.editUser!.passw != null ? widget.editUser!.passw! : '';
      }
      super.initState();
    }

    @override
    void dispose() {
      inputUserController.dispose();
      inputPassController.dispose();
      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
          child: Form(
            key: myRecord,
            child: Column(
              children: [
                const Text(
                  'Formulario de Registro',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: inputUserController,
                  decoration: const InputDecoration(
                      hintText: 'Introduce tu usuario', labelText: 'Usuario'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'El Usuario es obligatorio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: inputPassController,
                  decoration: const InputDecoration(
                      hintText: 'Introduce tu contraseña',
                      labelText: 'Contraseña'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'La contraseña es obligatoria';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: inputPassController,
                  decoration: const InputDecoration(
                      hintText: 'Repite tu contraseña',
                      labelText: 'Contraseña 2'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'La contraseña 2 es obligatoria';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40.0),
                    ),
                    onPressed: () {
                      if (myRecord.currentState!.validate()) {
                        final userService =
                            Provider.of<UserProvider>(context, listen: false);
                        final bool equals =
                            inputPassController == repeatPassController;
                        if (equals) {
                          //Es un alta
                          userService.addUser(
                            inputUserController.text,
                            inputPassController.text,
                          );
                        }
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text(
                      'Agregar',
                      style: TextStyle(fontSize: 20.0),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
