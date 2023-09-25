import 'package:flutter/material.dart';

import 'video_page.dart';

class LoginPage extends StatefulWidget {
  final String? title;
  static const routName = '/login';

  const LoginPage({Key? key, this.title}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<LoginPage> {
  bool checked = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return loginPage();
  }

  Widget loginPage() {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 15, bottom: 30),
              child: Column(
                children: <Widget>[
                  Text(
                    'Crime Detections',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                  Text(
                    'IoT Engine Team',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
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
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: Text(
                          'Inicio de Sesión',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //const Text('Correo Electrónico'),
                            TextField(
                              decoration: const InputDecoration(
                                labelText: 'Correo Electrónico',
                                border: OutlineInputBorder(),
                              ),
                              controller: emailController,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //const Text('Contraseña'),
                            TextField(
                              decoration: const InputDecoration(
                                labelText: 'Contraseña',
                                border: OutlineInputBorder(),
                              ),
                              controller: passwordController,
                              obscureText: true,
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
                                onChanged: (value) => _changed(value!),
                              ),
                              TextButton(
                                  onPressed: () {
                                    _changed(!checked);
                                  },
                                  child: const Text('Recuérdame'))
                            ],
                          ),
                          const TextButton(
                            onPressed: null,
                            child: Text(
                              'Olvidé mi contraseña',
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Center(
                          child: OutlinedButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, VideoApp.routName),
                            child: const Text(
                              'Iniciar Sesión',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _changed(bool state) {
    setState(() {
      checked = state;
    });
  }
}
