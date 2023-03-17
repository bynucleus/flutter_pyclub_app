import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import '../api.dart';
import '../components.dart';
import '../globals.dart';
import '../styles.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:custom_clippers/custom_clippers.dart';

import '../models/others.dart';

class Panel extends StatefulWidget {
  const Panel({key, this.room});

  final String room;

  @override
  State<Panel> createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  TextEditingController _messageTxtField;
  bool _loading = false;

  dynamic _roomInfo = {};
  List<Question> _messages = [];

  @override
  void initState() {
    super.initState();
    getRoomMesage();
    _messageTxtField = TextEditingController();
    listenToWebSocket();
  }

  @override
  void dispose() {
    globalChannel.sink.close();
    super.dispose();
  }

  getRoomMesage() {
    Api.getRoomInfo(widget.room).then((value) {
      var jsontolist = value['questions'] as List;
      var questions =
          jsontolist.map((tagJson) => Question.fromJson(tagJson)).toList();
      setState(() {
        _roomInfo = value['room'];
        _messages = questions;
      });
    });
  }

  void submitForm() async {
    if (globalUser != null) {

      if ( _messageTxtField.text.isNotEmpty) {
        
      Future request = Api.askQuestion(widget.room, _messageTxtField.text);
      request.then((value) {
        if (value) {
          getRoomMesage();
          setState(() {
            _messageTxtField.text = "";
          });
        }
      });
      }
      else {
      showSuccess("Veuillez entrer un commentaire valide.");
    }

    } else {
      showSuccess("Veuillez vous connecter.");
    }
  }

  void listenToWebSocket() {
    // globalChannel = WebSocketChannel.connect(
    //   Uri.parse(socketAddress),
    // );
    // gblGroadcastChannel = globalChannel.stream.asBroadcastStream();

    // gblGroadcastChannel.listen((message) {
    //   print("message");
    //   var msg = jsonDecode(message);
    //   if (msg['message'] == "UPDATE-QUESTIONS") {
    //     if (msg["room"] == widget.room) {
    //       getRoomMesage();
    //     }
    //   }
    // });

    Timer.periodic(Duration(minutes: 3), (timer) {
      getRoomMesage();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> messageCards = [];
    for (var activity in _messages) {
      messageCards.add(messageCard(context, activity));
    }
    return Scaffold(
      appBar: backNavBar(context, "${_roomInfo['label'] ?? ''}", kPrimaryColor),
      body: Stack(children: [
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                  color: ksecondaryColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                "${_roomInfo['title'] ?? ''}".toUpperCase(),
                style: labelStyle,
                textAlign: TextAlign.center,
              ),
            )),
        Positioned(
            top: 60,
            bottom: 70,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: messageCards,
              ),
            )),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: gblSize.width - 70,
                      child: TextFormField(
                          style: const TextStyle(
                              fontSize: 15.0, height: 1, color: Colors.black),
                          controller: _messageTxtField,
                          keyboardType: TextInputType.streetAddress,
                          decoration:
                              textfieldAddress('Posez une question...'))),
                  IconBtn(
                    bgColor: kPrimaryColor.withOpacity(0.1),
                    icon: const Icon(Icons.send, color: kPrimaryColor),
                    padding: const EdgeInsets.all(13),
                    press: () {
                      submitForm();
                    },
                  )
                ],
              ),
            ))
      ]),
    );
  }

  Widget messageCard(BuildContext context, Question question) {
    return GestureDetector(
      onDoubleTap: () {
        // Api.makeQuestionAnswered(question.id!);
      },
      onLongPress: () {
        if (globalUser != null) {
          if (question.askBy == globalUser.id) {
            Api.deleteQuestion(question.id).whenComplete(() {
              showSuccess("Message supprimé");

              getRoomMesage();
            });
          }
        }

        // Api.activateQuestion(question.id!);
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ClipPath(
          clipper: UpperNipMessageClipper(MessageType.RECEIVE),
          child: Container(
            padding: const EdgeInsets.all(20),
            color: (question.answered)
                ? kPrimaryColor.withOpacity(0.0)
                : (question.active)
                    ? ksecondaryColor.withOpacity(0.5)
                    : kPrimaryColor.withOpacity(0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question.senderName ?? 'Inconnu',
                  style: msgSenderStyle,
                ),
                Text(
                  '${question.message}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
