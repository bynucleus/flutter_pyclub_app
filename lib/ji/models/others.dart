// To parse this JSON data, do
//
//     final activity = activityFromJson(jsonString);

import 'dart:convert';

Activity activityFromJson(String str) => Activity.fromJson(json.decode(str));

String activityToJson(Activity data) => json.encode(data.toJson());

class Activity {
  Activity({
    this.active,
    this.canInteract,
    this.id,
    this.title,
    this.description,
    this.time,
    this.room,
    this.rank,
  });

  bool active;
  bool canInteract;
  String id;
  String title;
  String description;
  String time;
  String room;
  int rank;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        active: json["active"],
        canInteract: json["canInteract"],
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        time: json["time"],
        room: json["room"],
        rank: json["rank"],
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "canInteract": canInteract,
        "_id": id,
        "title": title,
        "description": description,
        "time": time,
        "room": room,
        "rank": rank,
      };
}

// To parse this JSON data, do
//
//     final question = questionFromJson(jsonString);

Question questionFromJson(String str) => Question.fromJson(json.decode(str));

String questionToJson(Question data) => json.encode(data.toJson());

class Question {
  Question({
    this.message,
    this.askBy,
    this.room,
    this.senderName,
    this.answered,
    this.active = false,
    this.id,
    this.dtpost,
  });

  String message;
  String askBy;
  String senderName;
  String room;
  bool answered;
  bool active;
  String id;
  DateTime dtpost;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        message: json["message"],
        askBy: json["askBy"],
        senderName: json["senderName"],
        room: json["room"],
        answered: json["answered"],
        active: json["active"],
        id: json["_id"],
        dtpost: json["dtpost"] == null ? null : DateTime.parse(json["dtpost"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "askBy": askBy,
        "senderName": senderName,
        "room": room,
        "answered": answered,
        "active": active,
        "_id": id,
        "dtpost": dtpost?.toIso8601String(),
      };
}
