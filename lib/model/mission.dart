import 'package:flutter/cupertino.dart';
import 'dart:convert';


class Mission {
  int id;
  String classe;
  String debut;
  String description;
  String fin;
  String lien;
  String pcc;


  Mission({
    @required this.id,
    @required this.classe,
    @required this.debut,
    @required this.description,
    @required this.fin,
    @required this.lien, 
    @required this.pcc
  });

  factory Mission.fromJson(Map<String, dynamic> json) => Mission(
        id: json["id"],
        classe: json["classe"],
        description: json["description"],
        lien: json["lien"],
        debut: json["debut"],
        fin: json["fin"],
        pcc: json["pcc"],

      );

  Map<String, dynamic> toJson() => {
           "id": id,
        "classe": classe,
        "description": description,
        "lien": lien,
        "debut": debut,
        "fin": fin,
        "pcc": pcc,
      };

static List<Mission> missionsFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Mission.fromJson(data);
    }).toList();
  }



  // static MissionModel fromMap(Map<String, dynamic> map) {
  //   return MissionModel(
      
  //     classe: map['classe'],
  //     debut: map['debut'],
  //     description: map['description'],
  //     fin: map['fin'],
  //     lien: map['lien'],

  //   );
  // }
}
