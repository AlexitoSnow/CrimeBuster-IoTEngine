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
  // late VlcPlayerController _controller;
  final VlcPlayerController _controller = VlcPlayerController.network(
    shouldUsePublicUrls
        ? VIDEO_STREAMING_URL_PUBLIC
        : VIDEO_STREAMING_URL_TESTING,
    hwAcc: HwAcc.full,
    autoPlay: true,
    options: VlcPlayerOptions(),
  );

  late List<EventoModel> _list = [];
  bool playing = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.value.isPlaying != playing) {
        setState(() {
          playing = _controller.value.isPlaying;
        });
      }
    });
    getEvents();
  }

  @override
  void dispose() async {
    await _controller.stopRendererScanning();
    await _controller.dispose();
    super.dispose();
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
          drawer: Drawer(
              width: MediaQuery.of(context).size.width * 0.5,
              child: _userPane()),
          appBar: AppBar(
            title: Text(widget.title),
            actions: [
              Image.asset('assets/images/logo.png', height: 50, width: 50)
            ],
          ),
          body: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width,
                child: Stack(children: [
                  !playing
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Colors.purple,
                        ))
                      : SizedBox(),
                  VlcPlayer(
                    controller: _controller,
                    aspectRatio: _controller.value.aspectRatio,
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Eventos Detectados',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        )),
                    OutlinedButton(
                        onPressed: getEvents,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.purple,
                        ),
                        child: Text('Actualizar')),
                  ],
                ),
              ),
              Flexible(
                child: ListView.builder(
                    itemCount: _list.length,
                    itemBuilder: (BuildContext context, index) {
                      return _eventItem(_list[index]);
                    }),
              )
            ],
          ),
        ));
  }

  /// Panel de usuario
  Widget _userPane() {
    return ListView(
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
    );
  }

  /// Eventos detectados
  Widget _eventItem(var item) {
    return Tooltip(
      message: 'Reproducir evento',
      child: ListTile(
        title: Text(item.tipo),
        subtitle: Text(subtitle(item.fecha)),
        leading: const Icon(Icons.play_arrow_rounded),
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
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Mostrando ${item.tipo}\n',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          TextSpan(
                            text: subtitle(item.fecha),
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    content: SizedBox(
                      child: VlcPlayer(
                        controller: VlcPlayerController.file(
                          File(temp),
                          hwAcc: HwAcc.full,
                          autoPlay: true,
                        ),
                        aspectRatio: 16 / 9,
                      ),
                    ),
                    actions: [
                      SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context);
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

  /// Streamming de video
  Widget videoStream() {
    try {
      if (playing) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Hubo un problema con la camara. Enciéndala y presione "Actualizar"',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold))));
        return Center(
            child: CircularProgressIndicator(
          color: Colors.purple,
        ));
      } else {
        return VlcPlayer(
          controller: _controller,
          aspectRatio: 16 / 9,
          placeholder: Center(
              child: CircularProgressIndicator(
            color: Colors.purple,
          )),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Hubo un problema con la camara. Enciéndala y presione "Actualizar"',
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.red, fontWeight: FontWeight.bold))));
      return Center();
    }
  }

  /// Formateo de la fecha
  String subtitle(String subtitle) {
    List<String> fechaYhora = subtitle.split('T');
    var hora = fechaYhora[1].split('.')[0];
    return "El ${fechaYhora[0]} a las ${hora}";
  }

  /// Carga de eventos
  Future<void> getEvents() async {
    var temp = await EventoHttpService().getEventos(token: LoginPage.token);
    setState(() {
      _list = temp;
    });
  }
}
