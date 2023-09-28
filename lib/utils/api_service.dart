import 'dart:convert';
import 'dart:core';
import 'dart:io';
import '../models/EventoModel.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../pages/video_page.dart';

class AuthHttpService {
  final String _baseUrl =
      shouldUsePublicUrls ? API_URL_PUBLIC : API_URL_TESTING;

  Future<String> getAPIToken(
      {required String email, required String password}) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse("${_baseUrl}login"));
    request.body = json.encode({"email": email, "password": password});
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        Map<String, dynamic> jsonResponse = json.decode(responseBody);
        String token = jsonResponse["token"].toString();
        VideoApp.userName = jsonResponse["user"]["username"].toString();
        return token;
      } else {
        return '';
        //throw http.ClientException(response.reasonPhrase!);
      }
    } catch (e) {
      return 'Falla inesperada';
    }
  }
}

class EventoHttpService {
  final String _baseUrl =
      shouldUsePublicUrls ? API_URL_PUBLIC : API_URL_TESTING;

  Future<List<EventoModel>> getEventos({required String token}) async {
    Uri uri = Uri.parse("${_baseUrl}evento");
    http.Response response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: 'token $token',
    });
    if (response.statusCode == 200) {
      return eventoModelFromJson(response.body);
    } else {
      throw http.ClientException(response.body);
    }
  }

  Future<File?> getVideoFile(String videoFileName,
      {required String token}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'token $token',
    };
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
      return null;
      //throw http.ClientException(response.statusCode.toString());
    }
  }
}
