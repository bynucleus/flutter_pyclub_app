// To parse this JSON data, do
//
//     final competition = competitionFromJson(jsonString);

import 'dart:convert';

Competition competitionFromJson(String str) => Competition.fromJson(json.decode(str));

String competitionToJson(Competition data) => json.encode(data.toJson());

class Competition {
    Competition({
        this.id,
        this.title,
        this.description,
        this.voters = const [],
        this.image,
    });

    String id;
    String title;
    String description;
    List<String> voters;
    String image;

    factory Competition.fromJson(Map<String, dynamic> json) => Competition(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        voters: json["voters"] == null ? [] : List<String>.from(json["voters"].map((x) => x)),
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "voters": voters == null ? [] : List<dynamic>.from(voters.map((x) => x)),
        "image": image,
    };
}
