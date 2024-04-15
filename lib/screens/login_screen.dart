// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:peliculas_flutter/screens/home_screens.dart';
import 'package:peliculas_flutter/screens/register_screen.dart';
import 'package:peliculas_flutter/sqlite/database_helper.dart';
import 'package:peliculas_flutter/widgets/widgets.dart';
import 'package:quickalert/quickalert.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> mylogin = GlobalKey<FormState>();
    final Map<String, String> valuesInput = {
      'NickName': 'prueba',
      'password': '123456'
    };
    final DatabaseManager db = DatabaseManager.instance;
    // ignore: unused_local_variable
    final infoAlert = buildButton(
      onTap: () {
        print(context);
        QuickAlert.show(
          context: context,
          type: QuickAlertType.info,
          text: 'En desarrollo',
        );
      },
      title: 'Esto está en construcción',
      text: 'Buy two, get one free',
      leadingImage: 'assets/no-image.jpg',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
          child: Form(
            key: mylogin,
            child: Column(
              //Input de login
              children: [
                InputCustomer(
                  labelText: 'NickName',
                  hintText: 'Nombre del usuario',
                  formProperty: 'NickName',
                  keyboardType: TextInputType.name,
                  formValues: valuesInput,
                  icon: Icons.group_add_outlined,
                  suffixIcon: Icons.assignment_ind_outlined,
                ),
                const SizedBox(height: 30),
                InputCustomer(
                  labelText: 'Contraseña',
                  hintText: 'Contraseña del usuario',
                  obscureText: true,
                  formProperty: 'password',
                  keyboardType: TextInputType.visiblePassword,
                  formValues: valuesInput,
                  icon: Icons.security_outlined,
                  suffixIcon: Icons.remove_red_eye_outlined,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  child: const SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text('Entrar'),
                    ),
                  ),
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());

                    String? nombre = valuesInput['NickName'];
                    String? passw = valuesInput['password'];

                    Future<bool> verificar =
                        db.verifyCredentials(nombre!, passw!);

                    print(nombre);
                    print(passw);
                    print(verificar);

                    if (!mylogin.currentState!.validate()) {
                      print('Datos incorrectos!!!!');
                      infoAlert;
                    } else if (verificar == true) {
                      print(nombre);
                      print(passw);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                    } else if (verificar == false) {
                      print(nombre);
                      print(passw);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const RecordScreen()));
                    }
                  },
                ),

                const SizedBox(height: 50),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RecordScreen()),
                    );
                  },
                  child: const Text(
                      '¿Eres Nuevo en AppPelis? Crea una nueva cuenta, pulsando aquí',
                      maxLines: 2),
                ),

                //redes sociales
              ],
            ),
          ),
        ),
      ),
    );
  }

//Alert flutter
  Card buildButton({
    required onTap,
    required title,
    required text,
    required leadingImage,
  }) {
    return Card(
      shape: const StadiumBorder(),
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundImage: AssetImage(
            leadingImage,
          ),
        ),
        title: Text(title ?? ""),
        subtitle: Text(text ?? ""),
        trailing: const Icon(
          Icons.keyboard_arrow_right_rounded,
        ),
      ),
    );
  }
}
