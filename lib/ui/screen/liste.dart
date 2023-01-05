import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'package:myclub/model/ressource.dart';
import 'package:myclub/model/user.dart';
import 'package:myclub/services/http_service.dart';
import 'package:myclub/util/constant.dart';
import 'package:myclub/util/file_path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class ListePage extends StatefulWidget {
  const ListePage({Key key}) : super(key: key);

  @override
  _ListePageState createState() => _ListePageState();
}

class _ListePageState extends State<ListePage> {
  List<UserM> _users;
  bool _isLoadingUserList = true;
  var data;
  int somme = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

    setState(() {
      // print(missionController.fetchData());
    });
  }

  total() {
    if (data != null) {
      var t = 0;
      for (var d in data) {
        // print(typeOf d['status']);
        if (d['status'] == "0") t += int.parse(d['qte']) * 100;
      }
      setState(() {
        somme = t;
      });
    }
  }

  Future<void> getData() async {
    try {
      var response = await http.get(Uri.parse(API_URL_BASE + "achats"));
      var jsonString = response.body;
      data = json.decode(jsonString);
      total();
    } catch (Exception) {
      print(Exception);

      return false;
    }
    setState(() {
      _isLoadingUserList = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            var response =
                await http.get(Uri.parse(API_URL_BASE + "changeallstatus"));
            var jsonString = response.body;
            var data = json.decode(jsonString);
            getData();
            Fluttertoast.showToast(msg: "Tout à été payer");
          } catch (Exception) {
            print(Exception);
            Fluttertoast.showToast(msg: "Non Solder, error");
          }
        },
        child: Icon(Icons.reset_tv),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 34),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _contentHeader(),
              const SizedBox(
                height: 30,
              ),
              // const SizedBox(
              //   height: 16,
              // ),
              // const SizedBox(
              //   height: 30,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Montant à payer : ' + somme.toString() + " fr",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  // SvgPicture.asset(
                  //   scan,
                  //   color: Theme.of(context).iconTheme.color,
                  //   width: 18,
                  // ),
                ],
              ),
              const SizedBox(height: 16),
              const SizedBox(
                height: 30,
              ),
              _isLoadingUserList
                  ? Center(child: CircularProgressIndicator())
                  : _contentServices(
                      context, data.where((d) => d['status'] == "0").toList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contentHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Image.asset(
              "assets/images/myclubmini.png",
              width: 30, height: 30,
              // height: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              'Achats',
              style: Theme.of(context).textTheme.headline3,
            )
          ],
        ),
        InkWell(
          onTap: () {
            setState(() {
              // print('call');
              // xOffset = 240;
              // yOffset = 180;
              // scaleFactor = 0.7;
              // isDrawerOpen = true;
            });
          },
          child: SvgPicture.asset(
            menu,
            width: 16,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ],
    );
  }
}

Widget _contentServices(BuildContext context, List list) {
  return SizedBox(
    width: double.infinity,
    height: 500,
    child: GridView.count(
      crossAxisCount: 1,
      childAspectRatio: 4.10,
      children: list?.map((value) {
        return GestureDetector(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    // padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).cardColor,
                    ),
                    child: ListTile(
                      // trailing: Icon(Icons.add),
                      title: Text(
                        value["nom"] +
                            " - " +
                            value["qte"] +
                            " jus - ${int.parse(value['qte']) * 100} f\n" +
                            value["created_at"],
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    )
                    // SvgPicture.asset(
                    //   value.img,
                    //   color: Theme.of(context).iconTheme.color,
                    // ),
                    ),
              ],
            ));
      })?.toList(),
    ),
  );
}

_launchURL(String link) async {
  print(link);
  if (await canLaunch(link)) {
    await launch(link);
  } else {
    Fluttertoast.showToast(msg: "impossible d'ouvrir le lien : " + link);
    // throw 'Could not launch link';
  }
}

class ModelServices {
  String title, img;
  ModelServices({this.title, this.img});
}
