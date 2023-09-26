import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

import '../models/EventoModel.dart';
import '../utils/api_service.dart';
import '../utils/constants.dart';
import 'login_page.dart';

class VideoApp extends StatefulWidget {
  static const routName = '/video';

  final String title;

  const VideoApp({Key? key, required this.title}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VlcPlayerController _controller;
  late List<EventoModel> _list = [];

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
    var temp = await EventoHttpService().getEventos();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, LoginPage.routName);
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar Sesión',
          ),
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
                        child: VlcPlayer(
                          controller: _controller,
                          aspectRatio: 16 / 9,
                        ),
                      );
                    } else {
                      return const Center(
                          child:
                              CircularProgressIndicator(color: Colors.purple));
                    }
                  })),
          const Padding(padding: EdgeInsets.all(15)),
          const Text('Eventos Detectados',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              )),
          for (var item in _list)
            Tooltip(
              message: 'Ver Video',
              child: ListTile(
                title: Text(item.tipo),
                subtitle: Text(item.fecha),
                leading: const Icon(Icons.note),
                onTap: () async {
                  var temp = await EventoHttpService()
                      .getVideoFile(item.videoFileName);
                  _controller.setMediaFromFile(
                    temp,
                    hwAcc: HwAcc.full,
                    autoPlay: true,
                  );
                  /*
                  var temp = VlcPlayerController.file(
                      await EventoHttpService()
                          .getVideoFile(item.videoFileName),
                      hwAcc: HwAcc.full,
                      autoPlay: true,
                      options: VlcPlayerOptions());
                  setState(() {
                    _controller = temp;
                  });
                  */
                },
              ),
            )
        ],
      ),
    );
  }
}
