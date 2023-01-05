import 'package:flutter/cupertino.dart';
import 'dart:convert';

List<MissionModel> missionsModelFromJson(String str) =>
    List<MissionModel>.from(
        json.decode(str).map((x) => MissionModel.fromJson(x)));

String missionsModelToJson(List<MissionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  NewsModel({
    this.status,
    this.totalResults,
    this.articles,
  });

  String status;
  int totalResults;
  List<MissionModel> articles;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<MissionModel>.from(
            json["articles"].map((x) => MissionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "missions": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}
class MissionModel {
  int id;
  String classe;
  String debut;
  String description;
  String fin;
  String lien;
  String pcc;
  String club;


  MissionModel({
    @required this.id,
    @required this.classe,
    @required this.debut,
    @required this.description,
    @required this.fin,
    @required this.lien, 
    @required this.pcc,
    @required this.club,
  });

  factory MissionModel.fromJson(Map<String, dynamic> json) => MissionModel(
        id: json["id"],
        classe: json["classe"],
        description: json["description"],
        lien: json["lien"],
        debut: json["debut"],
        fin: json["fin"],
        pcc: json["pcc"],
        club: json["club"],

      );

  Map<String, dynamic> toJson() => {
           "id": id,
        "classe": classe,
        "description": description,
        "lien": lien,
        "debut": debut,
        "fin": fin,
        "pcc": pcc,
        "club": club,
      };
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
