import 'dart:convert';

import 'package:meta/meta.dart';

ScanModelo scanModelFromJson(String str) =>
    ScanModelo.fromJson(json.decode(str));

String scanModelToJson(ScanModelo data) => json.encode(data.toJson());

class ScanModelo {
  //nombre del modelo con la bbdd
  ScanModelo({
    this.id,
    this.tipo,
    @required this.valor,
  }) {
    if (this.valor.contains('http')) {
      this.tipo = 'http';
    } else {
      this.tipo = 'geo';
    }
  }

  int id;
  String tipo;
  String valor;

  factory ScanModelo.fromJson(Map<String, dynamic> json) => ScanModelo(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };
}
