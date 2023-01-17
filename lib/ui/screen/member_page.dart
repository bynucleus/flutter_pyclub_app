import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myclub/model/ressource.dart';
import 'package:myclub/model/user.dart';
import 'package:myclub/services/http_service.dart';
import 'package:myclub/util/constant.dart';
import 'package:myclub/util/file_path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({Key key}) : super(key: key);

  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  List<UserM> _users;
  bool _isLoadingUserList = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    setState(() {
      // print(missionController.fetchData());
    });
  }

  Future<void> getData() async {
    _users = await API_Manager.getAllUsers();

    setState(() {
      _isLoadingUserList = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                final contenu = TextEditingController();
                return AlertDialog(
                  title: const Text('Céer une séance ?'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: const <Widget>[
                        Text(
                            "vous êtes sur le point de créer une nouvelle reunion, à la date d'aujourd'hui"),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Approuver'),
                      onPressed: () {
                        API_Manager.createSeance();
                        Fluttertoast.showToast(msg: "nouvelle séance ajoutée");
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        },
        child: Icon(Icons.new_label),
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
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Progression Membre...',
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
                  : _contentServices(context, _users),
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
              'paramètres',
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

Widget _contentServices(BuildContext context, List missionsList) {
  return SizedBox(
    width: double.infinity,
    height: 500,
    child: GridView.count(
      crossAxisCount: 1,
      childAspectRatio: 4.10,
      children: missionsList?.map((value) {
        return GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  final contenu = TextEditingController();
                  return AlertDialog(
                    content: Stack(
                      // overflow: Overflow.visible,
                      children: <Widget>[
                        Positioned(
                          right: -40.0,
                          top: -40.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                        Form(
                          // key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: TextField(
                                  controller: contenu,
                                  decoration: InputDecoration.collapsed(
                                      hintText: "Entrez la valeur"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  child: Text("Valider"),
                                  onPressed: () {
                                    API_Manager.addPcc(value.id, contenu.text);
                                    print(contenu.text);

                                    Navigator.pop(context, false);
                                    Fluttertoast.showToast(msg: "pcc ajouter");

                                    // if (_formKey.currentState.validate()) {
                                    //   _formKey.currentState.save();
                                    // }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
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
                    trailing: Icon(Icons.add),
                    title: Text(
                      value.name + " - " + value.pcc + ' pcc',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  )
                  // SvgPicture.asset(
                  //   value.img,
                  //   color: Theme.of(context).iconTheme.color,
                  // ),
                  ),
              // const SizedBox(
              //   height: 8,
              // ),
              // Text(
              //   value.title,
              //   textAlign: TextAlign.center,
              //   style: Theme.of(context).textTheme.bodyText1,
              // ),
              // const SizedBox(
              //   height: 14,
              // ),
            ],
          ),
        );
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
