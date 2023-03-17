// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        this.roles,
        this.id,
        this.lastName,
        this.firstName,
        this.level,
        this.email,
        this.phoneNumber,
        this.password,
        this.invitationCode,
        this.photo,
        this.interests,
        this.orders,
        this.questions,
        this.paid = false,
    });

    List<dynamic> roles;
    String id;
    String lastName;
    String firstName;
    String level;
    String email;
    String phoneNumber;
    String password;
    String invitationCode;
    String photo;
    List<String> interests;
    List<String> orders;
    List<String> questions;
    bool paid;

    factory User.fromJson(Map<String, dynamic> json) => User(
        roles: json["roles"] == null ? [] : List<dynamic>.from(json["roles"].map((x) => x)),
        id: json["_id"],
        lastName: json["lastName"],
        firstName: json["firstName"],
        level: json["level"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        password: json["password"],
        invitationCode: json["invitationCode"],
        photo: json["photo"],
        interests: json["interests"] == null ? [] : List<String>.from(json["interests"].map((x) => x)),
        orders: json["orders"] == null ? [] : List<String>.from(json["orders"].map((x) => x)),
        questions: json["questions"] == null ? [] : List<String>.from(json["questions"].map((x) => x)),
        paid: json["paid"],
    );

    Map<String, dynamic> toJson() => {
        "roles": roles == null ? [] : List<dynamic>.from(roles.map((x) => x)),
        "_id": id,
        "lastName": lastName,
        "firstName": firstName,
        "level": level,
        "email": email,
        "phoneNumber": phoneNumber,
        "password": password,
        "invitationCode": invitationCode,
        "photo": photo,
        "interests": interests == null ? [] : List<dynamic>.from(interests.map((x) => x)),
        "orders": orders == null ? [] : List<dynamic>.from(orders.map((x) => x)),
        "questions": questions == null ? [] : List<dynamic>.from(questions.map((x) => x)),
        "paid": paid,
    };
}
