class SeanceModel {
  String date;
  String club;
  int id;

  List<List<String>> notes;
  List<List<String>> liste_presence;
  SeanceModel({this.date, this.id, this.club});

  // receiving data from server

  factory SeanceModel.fromRTDB(Map<String, dynamic> data) {
    return SeanceModel();
  }
 factory SeanceModel.fromJson(Map<String, dynamic> json) => SeanceModel(
        id: json["id"],
        club: json["club"],
        date: json["date"],

      );
        static List<SeanceModel> ressourcesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return SeanceModel.fromJson(data);
    }).toList();
  }

  // factory SeanceModel.fromMap(map) {
  //   return SeanceModel(
  //     uid: map['uid'],
  //     email: map['email'],
  //     firstName: map['firstName'],
  //     secondName: map['secondName'],
  //   );
  // }

  // sending data to our server
  // Map<String, dynamic> toMap() {
  //   return {
  //     'uid': uid,
  //     'email': email,
  //     'firstName': firstName,
  //     'secondName': secondName,
  //   };
  // }
}
