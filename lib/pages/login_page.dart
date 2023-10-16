import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../utils/api_service.dart';
import 'video_page.dart';
import 'package:path_provider/path_provider.dart';

class LoginPage extends StatefulWidget {
  final String? title;
  static String token = '';
  static const routName = '/login';

  const LoginPage({Key? key, this.title}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<LoginPage> {
  bool checked = false;
  bool seePassword = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return loginPage();
  }

  @override
  void initState() {
    super.initState();
    _checkCredentials();
  }

  Widget loginPage() {
    return Scaffold(
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/computer.png', width: 75, height: 75),
            Image.asset('assets/images/niot.png', width: 60, height: 60),
          ],
        ),
      ],
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 25),
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Image.asset('assets/images/iconApp.png',
                      width: 150, height: 150),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  padding: const EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _formulario()),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _formulario() {
    return [
      const Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: Text(
          'Inicio de Sesión',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Correo Electrónico',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              autofocus: true,
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.password),
                suffixIcon: IconButton(
                    onPressed: _lookAt,
                    icon: Icon(
                        seePassword ? Icons.visibility_off : Icons.visibility)),
              ),
              controller: passwordController,
              obscureText: !seePassword,
              onSubmitted: (_) => _login(
                  email: emailController.text,
                  password: passwordController.text),
            ),
          ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              Checkbox(
                value: checked,
                onChanged: (value) => _rememberme(value!),
              ),
              TextButton(
                  onPressed: () {
                    _rememberme(!checked);
                  },
                  child: const Text('Recuérdame'))
            ],
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Center(
          child: OutlinedButton(
            onPressed: () => _login(
                email: emailController.text, password: passwordController.text),
            child: const Text(
              'Iniciar Sesión',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ];
  }

  void _rememberme(bool state) {
    setState(() {
      checked = state;
    });
  }

  void _login({required String email, required String password}) async {
    LoginPage.token =
        await AuthHttpService().getAPIToken(email: email, password: password);
    if (LoginPage.token == '') {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Error'),
                content: Text('Credenciales incorrectas'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Aceptar'))
                ],
              ));
    } else if (LoginPage.token == 'Falla inesperada') {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text('Error'),
                content: Text('Falla inesperada'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Aceptar'))
                ],
              ));
    } else {
      // Guardar credenciales en archivo si se seleccionó la opción de recordar
      if (checked) {
        final directory = await getApplicationSupportDirectory();
        final credentialsFile =
            await File('${directory.path}/credentials.json').create();
        final credentials = jsonEncode({'email': email, 'password': password});
        await credentialsFile.writeAsString(credentials);
      }
      Navigator.pushReplacementNamed(context, VideoApp.routName);
    }
  }

  void _lookAt() => setState(() {
        seePassword = !seePassword;
      });

  Future<void> _checkCredentials() async {
    //leer el archivo credentials.json para verificar si existen credenciales de inicio de sesión
    final directory = await getApplicationSupportDirectory();
    final credentialsFile = await File('${directory.path}/credentials.json');
    if (await credentialsFile.exists()) {
      print(credentialsFile.path);
      final email = jsonDecode(await credentialsFile.readAsString())['email'];
      final password =
          jsonDecode(await credentialsFile.readAsString())['password'];
      setState(() {
        emailController.text = email;
        passwordController.text = password;
        checked = true;
        _login(email: emailController.text, password: passwordController.text);
      });
    }
  }
}
