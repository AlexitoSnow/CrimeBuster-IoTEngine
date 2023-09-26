import 'dart:convert';

List<EventoModel> eventoModelFromJson(String str) => List<EventoModel>.from(
    json.decode(str).map((x) => EventoModel.fromJson(x)));
String eventoModelToJson(List<EventoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EventoModel {
  final String fecha;
  final String tipo;
  final String lat;
  final String long;
  final String videoFileName;

  EventoModel({
    required this.fecha,
    required this.tipo,
    required this.lat,
    required this.long,
    required this.videoFileName,
  });

  factory EventoModel.fromJson(Map<String, dynamic> json) => EventoModel(
      fecha: json["fecha"],
      tipo: json["tipo"],
      lat: json["lat"],
      long: json["long"],
      videoFileName: json["videoFileName"]);

  Map<String, dynamic> toJson() => {
        "fecha": fecha,
        "tipo": tipo,
        "lat": lat,
        "long": long,
        "videoFileName": videoFileName
      };
}
