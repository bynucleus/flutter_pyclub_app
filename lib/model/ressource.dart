import 'package:flutter/cupertino.dart';

class RessourceModel {
  int id;
  String titre;
  String lien;

  RessourceModel({
    @required this.id,
    @required this.titre,
    @required this.lien,
  });

  factory RessourceModel.fromJson(Map<String, dynamic> json) => RessourceModel(
        id: json["id"],
        titre: json["titre"],
        lien: json["lien"],
      );

  static List<RessourceModel> ressourcesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return RessourceModel.fromJson(data);
    }).toList();
  }

  static RessourceModel fromMap(Map<String, dynamic> map) {
    return RessourceModel(
      id: map['id'],
      titre: map['titre'],
      lien: map['lien'],
    );
  }
}
