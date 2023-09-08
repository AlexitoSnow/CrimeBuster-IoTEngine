import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  static const _title = 'Crime Detections | Login';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      home: HomePage(title: _title),
    );
  }
}

class HomePage extends StatefulWidget {
  final String? title;

  HomePage({Key? key, this.title}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

//Manejar cambios de estado en pantalla
class _HomePage extends State<HomePage> {

  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return loginPage();
  }

  Widget loginPage(){
    Color color = const Color.fromARGB(255, 157, 8, 184);
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            //Título y subtítulo
            Container(
              child: const Column(
                children: <Widget>[
                  Text('Crime Detections',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50
                  )),
                  Text('IoT Engine Team',
                  style: TextStyle(
                    fontSize: 30,
                  )),
                ],
              ),
            ),
            //const Padding(padding: EdgeInsets.all(15)),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              padding: const EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width / 1.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Text('Inicio de Sesión',
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )),
                  //Correo electrónico
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Correo Electrónico',),
                        TextField()
                      ],
                    ),
                  ),
                  //Contraseña
                  const Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Contraseña'),
                        TextField(obscureText: true)
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
                            activeColor: color,
                            onChanged: (value) => _changed(value!)),
                          const Text('Recuérdame'),
                        ],
                      ),
                      TextButton(
                        onPressed: null,
                        child: Text('Olvidé mi contraseña',
                        style: TextStyle(color: color),)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Center(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: color
                      ),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => VideoApp())),
                      child: const Text('Iniciar Sesión',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
                      ),
                    ),
                  ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changed(bool state){
    setState(() {
      checked = state;
    });
  }

}

class VideoApp extends StatefulWidget {
  final String? title;

  VideoApp({Key? key, this.title}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
        //'assets/videos/testVideo.mp4');
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(0.2);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color color = const Color.fromARGB(255, 157, 8, 184);
    List<String> list = [];
    List.generate(15, (index) => list.add('Evento ${index + 1}'));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crime Detections | Dashboard',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          backgroundColor: color,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 15)),
            Container(
              height: MediaQuery.of(context).size.height / 2.5,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator(color: Color.fromARGB(255, 157, 8, 184)));
                  }
                },
              ),
            ),
            const Padding(padding: EdgeInsets.all(15)),
            const Text('Eventos Detectados',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25
              )
            ),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder:(context, index) {
                  final item = list[index];
                  return ListTile(
                    title: Text(item),
                  );
                },
                ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: color,
          onPressed: () {
            setState(() {
              _controller.value.isPlaying ? _controller.pause() : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }
}