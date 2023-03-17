library ji_2023.globals;

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'api.dart';
import 'models/user.dart';

Size gblSize;
String gbltoken = '';
String gblTable;
bool isDeliverer = true;
User globalUser;
List<int> globalReceiver = [];

bool gblWaiting = false;
bool stilConnected = false;
bool isListeningGblChnl = false;

WebSocketChannel globalChannel = WebSocketChannel.connect(
  Uri.parse(socketAddress),
);

Stream gblGroadcastChannel = globalChannel.stream.asBroadcastStream();

loadData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  gbltoken = (prefs.getString('token') ?? '');
  String usr = (prefs.getString('globalUser') ?? '');
  globalUser = (usr != '')?  User.fromJson(jsonDecode(usr)) : null;
}

