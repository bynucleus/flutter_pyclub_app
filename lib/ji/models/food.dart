// To parse this JSON data, do
//
//     final food = foodFromJson(jsonString);

import 'dart:convert';

Food foodFromJson(String str) => Food.fromJson(json.decode(str));

String foodToJson(Food data) => json.encode(data.toJson());

class Food {
  Food({
    this.id,
    this.name,
    this.type,
    this.full = false,
    this.stock,
    this.image,
  });

  String id;
  String name;
  String type;
  bool full;
  int stock;
  String image;

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        id: json["_id"],
        name: json["name"],
        type: json["type"],
        full: json["full"] ?? false,
        stock: json["stock"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "full": full,
        "stock": stock,
        "image": image,
      };
}
