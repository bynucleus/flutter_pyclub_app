// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';

News newsFromJson(String str) => News.fromJson(json.decode(str));

String newsToJson(News data) => json.encode(data.toJson());

class News {
    News({
        this.id,
        this.title,
        this.description,
        this.image,
        this.dtpost,
    });

    String id;
    String title;
    String description;
    String image;
    DateTime dtpost;

    factory News.fromJson(Map<String, dynamic> json) => News(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        dtpost: json["dtpost"] == null ? null : DateTime.parse(json["dtpost"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "image": image,
        "dtpost": dtpost?.toIso8601String(),
    };
}
