import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

import '../models/EventoModel.dart';
import '../utils/api_service.dart';
import '../utils/constants.dart';
import 'login_page.dart';

class VideoApp extends StatefulWidget {
  static const routName = '/video';

  static String userName = 'User';

  final String title;

  const VideoApp({Key? key, required this.title}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VlcPlayerController _controller;
  late List<EventoModel> _list = [];
  bool _eventSelected = false;

  @override
  void initState() {
    super.initState();
    getEvents();
  }

  @override
  void dispose() async {
    await _controller.stopRendererScanning();
    await _controller.dispose();
    super.dispose();
  }

  void getEvents() async {
    var temp = await EventoHttpService().getEventos(token: LoginPage.token);
    setState(() {
      _list = temp;
    });
  }

  Future<void> initializePlayer() async {
    _controller = await VlcPlayerController.network(
      shouldUsePublicUrls
          ? VIDEO_STREAMING_URL_PUBLIC
          : VIDEO_STREAMING_URL_TESTING,
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
  }

  Widget evento(var item) {
    return Tooltip(
      message: 'Reproducir evento',
      child: ListTile(
        title: Text(item.tipo),
        subtitle: Text(subtitle(item.fecha)),
        leading: const Icon(Icons.play_arrow_rounded),
        selected: _eventSelected,
        onTap: () async {
          var temp = (await EventoHttpService()
                      .getVideoFile(item.videoFileName, token: LoginPage.token))
                  ?.path ??
              '';
          if (temp == '') {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Error al cargar el video')));
            return;
          } else {
            setState(() {
              //BUG: se seleccionan todos los eventos
              _eventSelected = true;
            });
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: Text('Mostrando ${item.tipo}'),
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2.5,
                        width: MediaQuery.of(context).size.width,
                        child: VlcPlayer(
                          controller: VlcPlayerController.file(
                            File(temp),
                            hwAcc: HwAcc.full,
                            autoPlay: true,
                          ),
                          aspectRatio: 16 / 9,
                        ),
                      ),
                      SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              _eventSelected = false;
                            });
                          },
                          child: const Text('Cerrar'))
                    ],
                  );
                });
          }
        },
      ),
    );
  }

  Widget videoStream() {
    try {
      return VlcPlayer(
          controller: _controller,
          aspectRatio: 16 / 9,
          placeholder: const Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
            ),
          ));
    } catch (e) {
      print('Error');
      return const Center(
          child: Text(
              'Hubo un problema con la camara. Enciéndala y presione "Actualizar"',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)));
    }
  }

  String subtitle(String subtitle) {
    List<String> fechaYhora = subtitle.split('T');
    var hora = fechaYhora[1].split('.')[0];
    return "El ${fechaYhora[0]} a las ${hora}";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        // evita que regrese al login
        onWillPop: () async {
          return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('¿Desea salir de la aplicación?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('No')),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          exit(0);
                        },
                        child: const Text('Si'))
                  ],
                );
              });
        },
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              getEvents();
              initializePlayer();
              print('actualizando');
            },
            child: const Icon(Icons.refresh),
            tooltip: 'Actualizar',
          ),
          drawer: Drawer(
              child: ListView(
            children: [
              DrawerHeader(
                child: Column(
                  children: <Widget>[
                    Icon(Icons.account_circle, size: 100),
                    Text(VideoApp.userName),
                  ],
                ),
              ),
              Divider(),
              TextButton(
                  onPressed: () {
                    LoginPage.token = '';
                    Navigator.pushNamed(context, LoginPage.routName);
                  },
                  child: Text('Cerrar Sesión'))
            ],
          )),
          appBar: AppBar(
            title: Text(widget.title),
            actions: [
              Image.asset('assets/images/logo.png', height: 50, width: 50)
            ],
          ),
          body: ListView(
            children: [
              const Padding(padding: EdgeInsets.only(top: 15)),
              SizedBox(
                  height: MediaQuery.of(context).size.height / 2.5,
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder(
                      future: initializePlayer(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          print('done');
                          return AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: videoStream(),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.purple,
                            ),
                          );
                        }
                      })),
              const Padding(padding: EdgeInsets.all(15)),
              const Text('Eventos Detectados',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  )),
              for (var item in _list) evento(item)
            ],
          ),
        ));
  }
}
