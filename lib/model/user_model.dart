import 'package:flutter/cupertino.dart';

class UserModel {
  String uid;
  String fullName;
  String email;
  int pcc;
  String profileImage;

  UserModel({
    @required this.uid,
    @required this.fullName,
    @required this.email,
    @required this.profileImage,
    @required this.pcc
  });

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      fullName: map['noms'],
      email: map['email'],
      profileImage: map['profileImage'],
      pcc: map['pcc'],
    );
  }
}
