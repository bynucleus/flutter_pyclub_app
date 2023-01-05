import 'package:flutter/cupertino.dart';

class RessourceModel {
  int id;
  String titre;
  String lien;
  String club;

  RessourceModel({
    @required this.id,
    @required this.titre,
    @required this.lien,
    @required this.club,
  });

  factory RessourceModel.fromJson(Map<String, dynamic> json) => RessourceModel(
        id: json["id"],
        titre: json["titre"],
        lien: json["lien"],
        club: json["club"],
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
      club: map['club'],
    );
  }
}
