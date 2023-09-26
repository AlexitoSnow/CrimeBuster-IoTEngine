import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/video_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  static const _title = 'Crime Detections | Login';

  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.purple, // color de fondo
              foregroundColor: Colors.white, // color del texto
            ),
          ),
        ),
        home: const LoginPage(title: _title),
        routes: <String, WidgetBuilder>{
          LoginPage.routName: (BuildContext context) => const LoginPage(),
          VideoApp.routName: (BuildContext context) =>
              const VideoApp(title: 'Dashboard'),
        });
  }
}
