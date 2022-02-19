import 'package:flutter/cupertino.dart';

class UserM {
  int id;
  String name;
  String prenom;
  String niveau;
  String email;
  String pcc;
  String profileImage;

  UserM(
      {@required this.id,
      @required this.name,
      @required this.prenom,
      @required this.niveau,
      @required this.email,
      @required this.profileImage,
      @required this.pcc});

 factory UserM.fromJson(Map<String, dynamic> json) => UserM(
        id: json["id"],
        name: json["name"],
        prenom: json["prenom"],
        niveau: json["niveau"],
        email: json["email"],
        pcc: json["pcc"],
        profileImage: json["profileImage"],
      );

        static List<UserM> usersFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return UserM.fromJson(data);
    }).toList();
  }
  // static UserModel fromMap(Map<String, dynamic> map) {
  //   return UserModel(
  //     uid: map['uid'],
  //     fullName: map['noms'],
  //     email: map['email'],
  //     profileImage: map['profileImage'],
  //     pcc: map['pcc'],
  //   );
  // }
}
