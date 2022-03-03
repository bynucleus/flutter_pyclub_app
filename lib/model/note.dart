import 'package:flutter/cupertino.dart';
import 'dart:convert';


class Note {
  int id;
  String seanceid;
  String titre;
  String nom;
  String contenu;
  String date;



  Note({
    @required this.id,
    @required this.seanceid,
    @required this.titre,
    @required this.nom,
    @required this.contenu,
    @required this.date,

  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json["id"],
        seanceid: json["seance_id"],
        titre: json["titre"],
        nom: json["nom"],
        contenu: json["contenu"],
        date: json["created_at"].substring(0, 20),
 

      );

  Map<String, dynamic> toJson() => {
           "id": id,
        "seance_id": seanceid,
        "titre": titre,
        "nom": nom,
        "contenu": contenu,
        "date": date,
   
      };

static List<Note> NotesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Note.fromJson(data);
    }).toList();
  }



  // static NoteModel fromMap(Map<String, dynamic> map) {
  //   return NoteModel(
      
  //     classe: map['classe'],
  //     debut: map['debut'],
  //     description: map['description'],
  //     fin: map['fin'],
  //     lien: map['lien'],

  //   );
  // }
}
