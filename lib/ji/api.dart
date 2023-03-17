import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/candidate.dart';
import 'models/competition.dart';
import 'models/food.dart';
import 'models/news.dart';
import 'models/order.dart';
import 'styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart';
import 'models/others.dart';
import 'models/user.dart';

// ------------- IP ADDRESS ---------------------

// const ipAddress = "http://109.205.181.210:10";
// const socketAddress = 'ws://109.205.181.210:11';
const ipAddress = "https://miage-ufhb.ci";
const socketAddress = 'ws://109.205.181.210:9001';
const ipAddressApi = "$ipAddress/api";

Map<String, String> headers = <String, String>{
  'Content-Type': 'application/json; charset=UTF-8',
  'Authorization': 'Token $gbltoken'
};

class Api {
  static Future<bool> login(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('$ipAddressApi/users/login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      if (data['success'] == true) {
        gbltoken = data['data']['token'];
        await prefs.setString('token', data['data']['token']);
        globalUser = User.fromJson(data['data']['user']);
        await prefs.setString("globalUser", json.encode(globalUser.toJson()));
      }
      showSuccess(data['message'].toString());
      return data['success'];
    } else {
      showErrorToast("identifiants erronés! veuillez reessayer.");
      return false;
    }
  }

  static Future<String> sendDocument(String file) async {
    var request = http.MultipartRequest(
      'PUT',
      Uri.parse('$ipAddressApi/users/${globalUser.id}'),
    );
    request.files.add(await http.MultipartFile.fromPath('photo', file));
    request.headers['Authorization'] = 'Token $gbltoken';
    var response = await request.send();
    return response.reasonPhrase;
  }

  static Future<bool> updateInfo(
      String firstName, String lastName, String phoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.put(
      Uri.parse('$ipAddressApi/users/${globalUser.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      if (data['success'] == true) {
        globalUser = User.fromJson(data['data']['user']);
        await prefs.setString("globalUser", json.encode(globalUser.toJson()));
      }
      showSuccess(data['message'].toString());
      return data['success'];
    } else {
      showErrorToast("Une erreur s'est produite");
      return false;
    }
  }

  static Future<User> retrieveUser(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Uri uri = Uri.parse('$ipAddressApi/users/$userId');

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      await prefs.setString('globalUser', jsonEncode(data['data']['user']));
      globalUser = User.fromJson(data['data']['user']);
      return User.fromJson(data['data']['user']);
    }
    return null;
  }

  static Future<List<Activity>> getActivities() async {
    final response = await http.get(Uri.parse('$ipAddressApi/activities/'));

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      var jsontolist = data['data']['activities'] as List;
      return jsontolist.map((tagJson) => Activity.fromJson(tagJson)).toList();
    } else {
      return [];
    }
  }

  static Future<List<Food>> getFoodsbyType(String type) async {
    final response = await http
        .get(Uri.parse('$ipAddressApi/foods/type/${type.toUpperCase()}'));

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      var jsontolist = data['data']['foods'] as List;
      return jsontolist.map((tagJson) => Food.fromJson(tagJson)).toList();
    } else {
      return [];
    }
  }

  static Future<List<News>> getNews() async {
    final response = await http.get(Uri.parse('$ipAddressApi/news/'));

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      var jsontolist = data['data']['news'] as List;
      return jsontolist.map((tagJson) => News.fromJson(tagJson)).toList();
    } else {
      return [];
    }
  }

  static Future<List> getRooms() async {
    final response = await http.get(Uri.parse('$ipAddressApi/rooms/'));

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      var jsontolist = data['data']['rooms'] as List;
      return jsontolist;
    } else {
      return [];
    }
  }

  static Future<List<Competition>> getCompetitions() async {
    final response = await http.get(Uri.parse('$ipAddressApi/competitions/'));

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      var jsontolist = data['data']['competitions'] as List;
      return jsontolist
          .map((tagJson) => Competition.fromJson(tagJson))
          .toList();
    } else {
      return [];
    }
  }

  static Future<List<String>> getTables() async {
    final response = await http.get(Uri.parse('$ipAddressApi/tables/'));

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      var jsontolist = data['data']['tables'] as List;
      return jsontolist.map((tagJson) => "$tagJson").toList();
    } else {
      return [];
    }
  }

  static Future<List<Candidate>> getCandidates(String competitionId) async {
    final response =
        await http.get(Uri.parse('$ipAddressApi/candidates/$competitionId'));

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      var jsontolist = data['data']['candidates'] as List;
      return jsontolist.map((tagJson) => Candidate.fromJson(tagJson)).toList();
    } else {
      return [];
    }
  }

  static Future getRoomInfo(String room) async {
    final response =
        await http.get(Uri.parse('$ipAddressApi/rooms/info/$room'));

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));

      return data['data'];
    } else {
      return [];
    }
  }

  static Future<bool> askQuestion(String room, String question) async {
    final response = await http.post(
      Uri.parse('$ipAddressApi/questions/'),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        'message': question,
        'askBy': globalUser.id,
        'senderName': globalUser.firstName,
        'room': room,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['success'];
    } else {
      return false;
    }
  }

  static Future<bool> voteProject(
      String competitionId, String candidateId, String userId) async {
    final response = await http.post(
      Uri.parse('$ipAddressApi/votes/'),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        'competitionId': competitionId,
        'candidateId': candidateId,
        'userId': globalUser.id,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['success'];
    } else {
      return false;
    }
  }

  static Future<bool> activateQuestion(String questionId) async {
    final response = await http.put(
      Uri.parse('$ipAddressApi/questions/$questionId/activate'),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        'question': questionId,
      }),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['success'];
    } else {
      return false;
    }
  }

  static Future<bool> makeQuestionAnswered(String questionId) async {
    final response = await http.put(
      Uri.parse('$ipAddressApi/questions/$questionId/answer'),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        'question': questionId,
      }),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['success'];
    } else {
      return false;
    }
  }

  static Future<bool> deleteQuestion(String questionId) async {
    final response = await http.delete(
      Uri.parse('$ipAddressApi/questions/$questionId'),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        'question': questionId,
      }),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      return data['success'];
    } else {
      return false;
    }
  }

  static Future<List<Order>> getOrders() async {
    final response = await http
        .get(Uri.parse('$ipAddressApi/orders/user/${globalUser.id}'));

    if (response.statusCode == 200) {
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      var jsontolist = data['data']['orders'] as List;
      return jsontolist.map((tagJson) => Order.fromJson(tagJson)).toList();
    } else {
      return [];
    }
  }

  static Future passOrder(Order order) async {
    final response = await http.post(
      Uri.parse('$ipAddressApi/orders/'),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        "table": order.table,
        "foods": json.encode(order.foods),
        "orderedBy": order.orderedBy,
      }),
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));
    return data;
  }
}
