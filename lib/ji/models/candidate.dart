// To parse this JSON data, do
//
//     final candidate = candidateFromJson(jsonString);

import 'dart:convert';

Candidate candidateFromJson(String str) => Candidate.fromJson(json.decode(str));

String candidateToJson(Candidate data) => json.encode(data.toJson());

class Candidate {
  Candidate({
    this.id,
    this.name,
    this.description,
    this.competition,
    this.votes,
    this.image,
  });

  String id;
  String name;
  String description;
  String competition;
  int votes;
  String image;

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        competition: json["competition"],
        votes: json["votes"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "competition": competition,
        "votes": votes,
        "image": image,
      };
}
