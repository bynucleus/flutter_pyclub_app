import 'dart:convert';
import 'dart:ffi';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:myclub/model/listePresence.dart';
import 'package:myclub/model/mission.dart';
import 'package:myclub/model/mission_model.dart';
import 'package:myclub/model/note.dart';
import 'package:myclub/model/ressource.dart';
import 'package:myclub/model/seance.dart';
import 'package:myclub/model/user.dart';
import 'package:myclub/util/constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

_club() async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  return jsonDecode(localStorage.getString('club'));
}

class HttpService {
  static var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token'))['token'];
  }

  static authData(data, apiUrl) async {
    try {
      var fullUrl = Uri.parse(API_URL_BASE + apiUrl);
      return await http.post(fullUrl,
          body: jsonEncode(data), headers: _setHeaders());
    } catch (error, stacktrace) {
      print("Exception trouvée: $error stackTrace: $stacktrace");
      return false;
    }
  }

  getData(apiUrl) async {
    var fullUrl = Uri.parse(API_URL_BASE + apiUrl);

    try {
      await _getToken();
      return await http.get(fullUrl, headers: _setHeaders());
    } catch (error, stacktrace) {
      print("Exception trouvée: $error stackTrace: $stacktrace");
      return false;
    }
  }

  static _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

  // static var client = http.Client();
  static Future<List<MissionModel>> fetchMissions() async {
    // print("pff");
    var club = await _club();

    var response =
        await http.get(Uri.parse("http://192.168.1.14:8181/api/missions"));
    if (response.statusCode == 200) {
      var data = response.body;
      print(data);
      return missionsModelFromJson(data).where((mi) => mi.club == club).toList();
    } else {
      // throw Exception();
      var data = response.body;
      return missionsModelFromJson(data).where((mi) => mi.club == club).toList();
    }
  }
}

// ignore: camel_case_types
class API_Manager {
  static Future<List<SeanceModel>> getSeances() async {
    var client = http.Client();
    var seances = [];
    var club = await _club();
    try {
      var response = await client.get(Uri.parse(API_URL_BASE + "seances"));
      // if (response.statusCode == 200) {
      var jsonString = response.body;
      var data = json.decode(jsonString);

      print(response.statusCode);
      seances = SeanceModel.ressourcesFromSnapshot(data);
      // print(seances);

      // for(var i in data)
      //   newsModel = NewsModel.fromJson(jsonMap);
      // }
    } catch (Exception) {
      print(Exception);

      return seances.where((seance) => seance.club == club).toList();
    }

    return seances.where((seance) => seance.club == club).toList();
    ;
  }

  static Future<List<Mission>> getMissions() async {
    var client = http.Client();
    var missions = [];
    var club = await _club();

    try {
      var response = await client.get(Uri.parse(API_URL_BASE + "missions"));
      // if (response.statusCode == 200) {
      var jsonString = response.body;
      var data = json.decode(jsonString);

      print(response.statusCode);
      missions = Mission.missionsFromSnapshot(data);
      print(missions);

      // for(var i in data)
      //   newsModel = NewsModel.fromJson(jsonMap);
      // }
    } catch (Exception) {
      print(Exception);

      return missions.where((mi) => mi.club == club).toList();
    }

    return missions.where((mi) => mi.club == club).toList();
  }

  static Future<List<RessourceModel>> getRessources() async {
    var client = http.Client();
    var ressources = [];
    var club = await _club();
    try {
      var response = await client.get(Uri.parse(API_URL_BASE + "ressources"));
      // if (response.statusCode == 200) {
      var jsonString = response.body;
      var data = json.decode(jsonString);

      print(response.statusCode);
      ressources = RessourceModel.ressourcesFromSnapshot(data);
      print(ressources);

      // for(var i in data)
      //   newsModel = NewsModel.fromJson(jsonMap);
      // }
    } catch (Exception) {
      print(Exception);

      return ressources.where((re) => re.club == club).toList();
    }

    return ressources.where((re) => re.club == club).toList();
  }

  static Future<List<UserM>> getUsers() async {
    var client = http.Client();
    var users = [];

    var club = await _club();
    try {
      // print(club);
      var response = await client.get(Uri.parse(API_URL_BASE + "users"));
      // if (response.statusCode == 200) {
      var jsonString = response.body;
      var data = json.decode(jsonString);

      // print(data.toString());
      users = UserM.usersFromSnapshot(data);
      // print(users);

      // for(var i in data)
      //   newsModel = NewsModel.fromJson(jsonMap);
      // }
    } catch (Exception) {
      print(Exception);

      return users.where((user) => user.club == club).toList();
    }

    return users.where((user) => user.club == club).toList();
  }

 static Future<List<UserM>> getAllUsers() async {
    var client = http.Client();
    var users = [];

    var club = await _club();
    try {
      // print(club);
      var response = await client.get(Uri.parse(API_URL_BASE + "users"));
      // if (response.statusCode == 200) {
      var jsonString = response.body;
      var data = json.decode(jsonString);

      // print(data.toString());
      users = UserM.usersFromSnapshot(data);
      // print(users);

      // for(var i in data)
      //   newsModel = NewsModel.fromJson(jsonMap);
      // }
    } catch (Exception) {
      print(Exception);
    return users;

      // return users.where((user) => user.club == club).toList();
    }

    return users;
  }

  static Future<UserM> getUserByMail(String mail) async {
    var client = http.Client();
    var users;

    try {
      // print(">>>>>>>>>>>>>");
      print(Uri.parse(API_URL_BASE + "user?mail=" + mail));
      var response =
          await client.get(Uri.parse(API_URL_BASE + "user?mail=" + mail));
      // if (response.statusCode == 200) {
      var jsonString = response.body;
      var data = json.decode(jsonString);
      // print(">>>>>>>>>>>>>");

      print(response.statusCode.toString());
      users = UserM.fromJson(data);
      print(users);

      // for(var i in data)
      //   newsModel = NewsModel.fromJson(jsonMap);
      // }
    } catch (Exception) {
      // print(">>>>>>>>>>>>>");

      print(Exception.toString());

      return users;
    }

    return users;
  }

  static Future<List<Note>> getNoteBySeance(int id) async {
    var client = http.Client();
    var notes;

    try {
      var response =
          await client.get(Uri.parse(API_URL_BASE + "note/" + id.toString()));
      // if (response.statusCode == 200) {
      var jsonString = response.body;
      var data = json.decode(jsonString);

      print("----------->" + data.toString());
      notes = Note.NotesFromSnapshot(data);
      // print("---r-------->" + notes);

      // for(var i in data)
      //   newsModel = NewsModel.fromJson(jsonMap);
      // }
    } catch (Exception) {
      print(Exception);

      return notes;
    }

    return notes;
  }

  static Future<List<ListeModel>> geListePBySeance(int id) async {
    var client = http.Client();
    var liste = [];

    try {
      var response =
          await client.get(Uri.parse(API_URL_BASE + "liste/" + id.toString()));
      // if (response.statusCode == 200) {
      var jsonString = response.body;
      var data = json.decode(jsonString);

      print(data.toString());
      liste = ListeModel.listesFromSnapshot(data);
      print(liste);

      // for(var i in data)
      //   newsModel = NewsModel.fromJson(jsonMap);
      // }
    } catch (Exception) {
      print(Exception);

      return liste;
    }

    return liste;
  }

  Future<UserM> createUser(String name, String prenom, String email,
      String niveau, String pass) async {
    // print(niveau);
    final response = await http.post(Uri.parse(API_URL_BASE + "users"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "name": name,
          "prenom": prenom,
          "email": email,
          "niveau": niveau,
          "password": pass,
        }));
    // print("fffffffffffffffffff");
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return UserM.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create user.');
    }
  }

  static Future<ListeModel> addPresence(String nom, int seance_id) async {
    // print("creation");
    final response = await http.post(Uri.parse(API_URL_BASE + "listes"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "nom": nom,
          "seance_id": seance_id.toString(),
        }));

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return ListeModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to add presence.');
    }
  }

  static Future<Note> addNote(String nom, int seance_id, String contenu) async {
    // print("creation");
    final response = await http.post(Uri.parse(API_URL_BASE + "notes"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "nom": nom,
          "contenu": contenu,
          "seance_id": seance_id.toString(),
        }));

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Note.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to add presence.');
    }
  }

  static Future<UserM> addPcc(int id, String pcc) async {
    // print("creation");
    final response = await http.post(Uri.parse(API_URL_BASE + "user/pcc"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "user_id": id.toString(),
          "pcc": pcc,
        }));

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return UserM.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to add pcc.');
    }
  }

  static Future<UserM> retPcc(int id, int pcc, String nom, int qte) async {
    // print("creation");
    var ok = await setAchat(nom, qte);
    if (ok) {
      final response = await http.post(Uri.parse(API_URL_BASE + "user/retpcc"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "user_id": id.toString(),
            "pcc": pcc.toString(),
          }));

      if (response.statusCode == 201 || response.statusCode == 200) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        return UserM.fromJson(jsonDecode(response.body));
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        // Fluttertoast.showToast(msg: "error");
        throw Exception("Echec de l'achat.");
      }
    } else {
      throw Exception("Echec de l'achat.");
    }
  }

  static Future<UserM> setAvatar(int id, String avatar) async {
    // print("creation");
    final response = await http.post(Uri.parse(API_URL_BASE + "user/avatar"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "user_id": id.toString(),
          "avatar": avatar,
        }));

    if (response.statusCode == 200 || response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return UserM.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to add avatar.');
    }
  }

  static Future<SeanceModel> createSeance() async {
    // print("creation");
    final response = await http.post(Uri.parse(API_URL_BASE + "seances"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{}));

    if (response.statusCode == 200 || response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return SeanceModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create seance.');
    }
  }

  static Future<bool> setAchat(String nom, int qte) async {
    try {
      var response = await http.get(
          Uri.parse(API_URL_BASE + "setAchat/" + nom + "/" + qte.toString()));
      var jsonString = response.body;
      var data = json.decode(jsonString);
      return true;
    } catch (Exception) {
      print(Exception);

      return false;
    }
  }
}
