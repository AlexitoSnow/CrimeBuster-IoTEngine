import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

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

  @override
  void initState() {
    _controller = VlcPlayerController.network(
      shouldUsePublicUrls
          ? VIDEO_STREAMING_URL_PUBLIC
          : VIDEO_STREAMING_URL_TESTING,
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
    super.initState();
  }

  @override
  void dispose() async {
    await _controller.stopRendererScanning();
    await _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> list = [];
    List.generate(15, (index) => list.add('Evento ${index + 1}'));

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
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VlcPlayer(
                controller: _controller,
                aspectRatio: 16 / 9,
                placeholder: const Center(
                    child: CircularProgressIndicator(color: Colors.purple)),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(15)),
          const Text('Eventos Detectados',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              )),
          ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              final item = list[index];
              return ListTile(
                title: Text(item),
                leading: const Icon(Icons.note),
              );
            },
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       _controller.value.isPlaying
      //           ? _controller.pause()
      //           : _controller.play();
      //     });
      //   },
      //   child: Icon(
      //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //   ),
      // ),
    );
  }
}
