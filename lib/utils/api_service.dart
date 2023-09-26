import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:crime_detections/models/EventoModel.dart';
import 'package:crime_detections/utils/constants.dart';
import 'package:path_provider/path_provider.dart';

class AuthHttpService {
  // TODO: Mas o menos tengo el auth en el backend, no lo he probado
}

class EventoHttpService {
  final String _baseUrl =
      shouldUsePublicUrls ? API_URL_PUBLIC : API_URL_TESTING;

  Future<List<EventoModel>> getEventos() async {
    Uri uri = Uri.parse("${_baseUrl}evento");
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      return eventoModelFromJson(response.body);
    } else {
      throw http.ClientException(response.body);
    }
  }

  Future<File> getVideoFile(String videoFileName) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET', Uri.parse('${_baseUrl}video'));
    request.body = json.encode({"videoFileName": videoFileName});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Directory temp = await getTemporaryDirectory();
      File archivo = File('${temp.path}/$videoFileName');
      archivo.writeAsBytesSync(await response.stream.toBytes());
      print(await archivo.length());
      print(await archivo.path);
      return archivo;
    } else {
      throw http.ClientException(response.statusCode.toString());
    }

    /*
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final Map<String, String> queryParams = {"videoFileName": videoFileName};
    final uri = Uri.http(_baseUrl.split("/")[2], "/api/video", queryParams);
    http.Response response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      Directory temp = await getTemporaryDirectory();
      File archivo = File(temp.path);
      await archivo.writeAsBytes(response.bodyBytes);
      return archivo;
    } else {
      throw http.ClientException(response.body);
    }
    */
  }
}
