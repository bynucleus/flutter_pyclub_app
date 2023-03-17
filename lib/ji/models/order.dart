// To parse this JSON data, do
//
//     final orders = ordersFromJson(jsonString);

import 'dart:convert';

import 'food.dart';

Order ordersFromJson(String str) => Order.fromJson(json.decode(str));

String ordersToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    this.id,
    this.status,
    this.table,
    this.orderedBy,
    this.foods,
  });

  String id;
  int status;
  String table;
  String orderedBy;
  List<Food> foods;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["_id"],
        status: json["status"],
        table: json["table"],
        orderedBy: json["orderedBy"],
        foods: json["foods"] == null
            ? []
            : List<Food>.from(
                json["foods"].map((x) => Food.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "table": table,
        "orderedBy": orderedBy,
        "foods": foods == null
            ? []
            : List<dynamic>.from(foods.map((x) => x.toJson())),
      };
}

class Minfood {
  Minfood({
    this.minfoodId,
    this.name,
    this.image,
    this.id,
  });

  String minfoodId;
  String name;
  String image;
  String id;

  factory Minfood.fromJson(Map<String, dynamic> json) => Minfood(
        minfoodId: json["id"],
        name: json["name"],
        image: json["image"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": minfoodId,
        "name": name,
        "image": image,
        "_id": id,
      };
}
