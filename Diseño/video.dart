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
          Video(),
        ]),
      ),
    );
  }
}

class Video extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 299,
          height: 234,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(),
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
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 116,
                top: 52,
                child: Container(
                  width: 107,
                  height: 65,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/107x65"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 80,
                top: 133,
                child: Container(
                  width: 15,
                  height: 10,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/15x10"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 80,
                top: 152,
                child: Container(
                  width: 15,
                  height: 10,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/15x10"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 80,
                top: 190,
                child: Container(
                  width: 15,
                  height: 10,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/15x10"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 80,
                top: 171,
                child: Container(
                  width: 15,
                  height: 10,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/15x10"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 100,
                top: 135,
                child: Container(
                  width: 70.38,
                  height: 63.15,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/70x63"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 19,
                child: Container(
                  width: 56,
                  height: 215,
                  decoration: BoxDecoration(color: Color(0xFFCFB1FF)),
                ),
              ),
              Positioned(
                left: 9,
                top: 44,
                child: Container(
                  width: 33,
                  height: 32,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/33x32"),
                      fit: BoxFit.fill,
                    ),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              Positioned(
                left: 7,
                top: 79,
                child: SizedBox(
                  width: 38,
                  height: 13,
                  child: Text(
                    'Usuario',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
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
                left: 0,
                top: 204,
                child: SizedBox(
                  width: 54,
                  height: 12,
                  child: Text(
                    'Cerrar sesión',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF000108),
                      fontSize: 7,
                      fontFamily: 'Kokoro',
                      fontWeight: FontWeight.w400,
                      textDecoration: TextDecoration.underline,
                      height: 0,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 244,
                top: 19,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/50x50"),
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