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
          Crear(),
        ]),
      ),
    );
  }
}

class Crear extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 299,
          height: 234,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 0,
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
                        left: 74,
                        top: 122,
                        child: Container(
                          width: 150.50,
                          height: 67.99,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://via.placeholder.com/150x68"),
                              fit: BoxFit.fill,
                            ),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 1,
                                strokeAlign: BorderSide.strokeAlignCenter,
                                color: Color(0x5BF6A320),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 105,
                top: 80,
                child: SizedBox(
                  width: 93,
                  height: 16,
                  child: Text(
                    'Creación de Cuenta',
                    textAlign: TextAlign.center,
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
                left: 111,
                top: 199,
                child: SizedBox(
                  width: 76,
                  height: 14,
                  child: Text(
                    'Crear Cuenta',
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
                left: 75,
                top: 125,
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
                left: 105,
                top: 105,
                child: SizedBox(
                  width: 57,
                  height: 9,
                  child: Text(
                    'Subir un avatar',
                    style: TextStyle(
                      color: Color(0xFF5A5151),
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
                left: 82,
                top: 142,
                child: SizedBox(
                  width: 46,
                  height: 9,
                  child: Text(
                    'Usuario',
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
                left: 82,
                top: 160,
                child: SizedBox(
                  width: 46,
                  height: 9,
                  child: Text(
                    'Contraseña',
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
                left: 82,
                top: 178,
                child: SizedBox(
                  width: 67,
                  height: 8,
                  child: Text(
                    'Confirmar contraseña',
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
                left: 82,
                top: 101,
                child: Container(
                  width: 19,
                  height: 18,
                  decoration: ShapeDecoration(
                    color: Color(0xFFF6A320),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 8,
                top: 22,
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
                left: 262,
                top: 22,
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
                left: 262,
                top: 22,
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
                left: 127,
                top: 22,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/44x44"),
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