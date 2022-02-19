class ListeModel {
  String date;
  String nom;
  int id;

  ListeModel({this.date, this.id,this.nom});


 factory ListeModel.fromJson(Map<String, dynamic> json) => ListeModel(
        id: json["id"],
        date: json["date"],
        nom: json["nom"],

      );
        static List<ListeModel> listesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return ListeModel.fromJson(data);
    }).toList();
  }


}
