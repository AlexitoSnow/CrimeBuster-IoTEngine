import 'package:flutter/material.dart';

void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(children: [
          Login(),
        ]),
      ),
    );
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 299,
          height: 234,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.11999999731779099),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 1,
                top: 0,
                child: Container(
                  width: 299,
                  height: 234,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 299,
                          height: 19.08,
                          child: Stack(children: [
                          ,
                          ]),
                        ),
                      ),
                      Positioned(
                        left: 75,
                        top: 122,
                        child: Container(
                          width: 149.50,
                          height: 38.89,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 24.90,
                                child: Container(
                                  width: 149.50,
                                  height: 13.99,
                                  child: Stack(children: [
                                  ,
                                  ]),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 149.50,
                                  height: 13.99,
                                  child: Stack(children: [
                                  ,
                                  ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 113,
                top: 80,
                child: SizedBox(
                  width: 76,
                  height: 14,
                  child: Text(
                    'Inicio de sesión',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontFamily: 'Kokoro',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 126,
                top: 100,
                child: SizedBox(
                  width: 49,
                  height: 13,
                  child: Text(
                    'Crear cuenta',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF0028FF),
                      fontSize: 8,
                      fontFamily: 'Kokoro',
                      fontWeight: FontWeight.w400,
                      textDecoration: TextDecoration.underline,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 80,
                top: 176,
                child: SizedBox(
                  width: 48,
                  height: 9,
                  child: Text(
                    'Recuérdame',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 6,
                      fontFamily: 'Kokoro',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 160,
                top: 176,
                child: SizedBox(
                  width: 63,
                  height: 9,
                  child: Text(
                    'Olvidé mi contraseña',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF0028FF),
                      fontSize: 6,
                      fontFamily: 'Kokoro',
                      fontWeight: FontWeight.w400,
                      textDecoration: TextDecoration.underline,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 112,
                top: 200,
                child: SizedBox(
                  width: 76,
                  height: 14,
                  child: Text(
                    'Iniciar Sesión',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 8,
                      fontFamily: 'Kokoro',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 74,
                top: 124,
                child: SizedBox(
                  width: 65,
                  height: 11,
                  child: Text(
                    'Correo electrónico',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF5A5151),
                      fontSize: 6,
                      fontFamily: 'Kokoro',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 74,
                top: 149,
                child: SizedBox(
                  width: 46,
                  height: 9,
                  child: Text(
                    'Contraseña',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF5A5151),
                      fontSize: 6,
                      fontFamily: 'Kokoro',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 77,
                top: 177,
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: ShapeDecoration(
                    color: Colors.black.withOpacity(0),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xFF060C8F)),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 262,
                top: 23,
                child: Container(
                  width: 29,
                  height: 29,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/29x29"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 8,
                top: 23,
                child: Container(
                  width: 29,
                  height: 29,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/29x29"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 128,
                top: 23,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/45x45"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}