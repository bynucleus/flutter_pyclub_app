// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ndialog/ndialog.dart';
import 'package:myclub/model/user.dart';
import 'package:myclub/services/http_service.dart';
import 'package:myclub/util/file_path.dart';
// import 'package:barcode_scan/barcode_scan.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:myclub/util/info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String result = "a";
  UserM user;
  UserM _user;

  int value = 1;
  bool retrait = false;
  TapGestureRecognizer _flutterTapRecognizer;
  @override
  void dispose() {
    _flutterTapRecognizer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    user = UserM(
        email: Info.email,
        name: Info.nom,
        club: Info.club,
        profileImage: Info.profileImage,
        pcc: Info.pcc,
        id: Info.id,
        niveau: Info.niveau);
    super.initState();
    _flutterTapRecognizer = new TapGestureRecognizer();
  }

  getNiveau(int pcc) {
    if (pcc != null) {
      if (pcc < 10000)
        return "Algoros";
      else if (pcc < 20000)
        return "Pascalin";
      else if (pcc < 40000)
        return "Codeur";
      else if (pcc >= 40000)
        return "Pythoniste";
      else
        return "Algoros";
    }
    return "Algoros";
  }

  Future<void> getUserDetails() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var email = localStorage.get("email");
    print(email);

    _user = await API_Manager.getUserByMail(email.toString());
    Info.nom = _user?.name;
    Info.club = _user?.club;
    Info.email = _user?.email;
    Info.profileImage = _user?.profileImage;
    Info.pcc = _user?.pcc;
    Info.id = _user?.id;
    Info.niveau = _user?.niveau;

    setState(() {
      // profileImage = "assets/svg/" + _user?.profileImage;
      // _isLoadingUser = false;
      // _verifAdmin = _user?.email;
    });
  }

  Future<void> getJus(var value) async {
    ProgressDialog progressDialog = ProgressDialog(
      context,
      dismissable: false,
      title: const Text('Traitement'),
      message: const Text('en cours ...'),
    );
    progressDialog.show();

    var res = await API_Manager.retPcc(
        user.id, value * Info.coutPcc, Info.nom, value);
    progressDialog.dismiss();

    res is UserM
        ? showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              retrait = false;
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter mystate) =>
                      NetworkGiffyDialog(
                        image:
                            Image(image: AssetImage("assets/images/meme.gif")),
                        title: Text('Retrait de jus',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22.0, fontWeight: FontWeight.w600)),
                        description: Text(
                          "Votre rétrait est confirmé, vous pouvez récuperer vos $value jus",
                          textAlign: TextAlign.center,
                        ),
                      ));
            })
        : Fluttertoast.showToast(
            msg: "Retrait de jus annulé, veuillez ressayer");

    setState(() {});
  }

  // Future _scanQR() async {
  //   try {
  //     ScanResult qrResult = await BarcodeScanner.scan();
  //     setState(() {
  //       result = qrResult.rawContent;
  //       retrait = true;
  //     });
  //     var verif = result.contains("Rami");
  //     verif
  //         ? getJus(value)
  //         : Fluttertoast.showToast(msg: "Retrait de jus annulé");
  //   } on PlatformException catch (ex) {
  //     if (ex.code == BarcodeScanner.cameraAccessDenied) {
  //       setState(() {
  //         result = "CAMERA permission denied!";
  //       });
  //       Fluttertoast.showToast(msg: result);
  //     } else {
  //       setState(() {
  //         result = "$ex Error occurred.";
  //       });
  //       Fluttertoast.showToast(msg: result);
  //     }
  //   } on FormatException {
  //     setState(() {
  //       result = "Nothing scanned!";
  //     });
  //     Fluttertoast.showToast(msg: result);
  //   } catch (ex) {
  //     setState(() {
  //       result = "$ex Error occured.";
  //     });
  //     Fluttertoast.showToast(msg: result);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* floatingActionButton: FloatingActionButton(
        onPressed: () {
            },
        // onPressed: () async {
        //   // Select Bar-Code or QR-Code photos for analysis
        //   _scanQR();
        // print("-----------------");

        //   print(result);
        // },
        child: Container(
            width: 60,
            height: 60,
            child: Icon(Icons.scanner),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
            )
            // gradient: LinearGradient(
            //   colors: [Colors.deepPurple[100],Colors.deepPurpleAccent],)),
            ),
      ),*/
      body: SingleChildScrollView(
          child: Column(
        children: [
          Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Image(
                    height: MediaQuery.of(context).size.height / 3,
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/dev.jpg")
                    // const NetworkImage(
                    //     'https://images.unsplash.com/photo-1485160497022-3e09382fb310?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fG1vdW50YWluc3xlbnwwfHwwfHw%3D&w=1000&q=80'),
                    ),
                Positioned(
                    top: 54,
                    // left: 20.0,
                    right: 24.0,
                    // bottom: -5.0,
                    child: SvgPicture.asset(
                      menu,
                      width: 18,
                      color: Theme.of(context).iconTheme.color,
                    )),
                Positioned(
                    bottom: -50.0,
                    child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: SvgPicture.asset("assets/svg/avator1.svg"))),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.47,
                    left: 20.0,
                    right: 20.0,
                    child: Card(
                        child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              child: Column(
                            children: [
                              Text(
                                'Niveau',
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 14.0),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                user?.niveau ?? "x",
                                // user.niveau,
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              )
                            ],
                          )),
                          Container(
                            child: Column(children: [
                              Text(
                                'pcc',
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 14.0),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                user?.pcc ?? "0",
                                // user.pcc,
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              )
                            ]),
                          ),
                          Container(
                              child: Column(
                            children: [
                              Text(
                                'progression',
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 14.0),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                getNiveau(user?.pcc != null
                                    ? int.parse(user?.pcc)
                                    : 1000),
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              )
                            ],
                          ),
                          ),
                          Container(
                              child: Column(
                            children: [
                              Text(
                                'club',
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 14.0),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                 user?.club ?? "miage",
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              )
                            ],
                          ))
                        ],
                      ),
                    )))
              ]),
          SizedBox(
            height: 45,
          ),
          ListTile(
            title: Center(child: Text(user?.name ?? "myclub")),
            subtitle: Center(child: Text("coder n'est qu'un jeux")),
          ),
          SizedBox(
            height: 100,
          ),
          ListTile(
            title: Text('Services'),
            subtitle: Text('Faites plus avec vos pcc'),
          ),
          SizedBox(
            height: 0,
          ),
          Divider(
            color: Colors.black,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.money_sharp,
                      color: Colors.red[400],
                      size: 35,
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pcc to Money",
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        Text(
                          "Convertissez vos pcc en argent",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey[400],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                IconButton(
                    icon: Icon(
                      Icons.next_week,
                      color: Colors.red[400],
                      size: 35,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            retrait = false;
                            return StatefulBuilder(
                                builder: (BuildContext context,
                                        StateSetter mystate) =>
                                    NetworkGiffyDialog(
                                      buttonCancelText: Text("cool"),
                                      buttonOkText: Text(" _ "),
                                      image: Image(
                                          image: AssetImage(
                                              "assets/images/men_wearing_jacket.gif")),
                                      title: Text('En developpement',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.w600)),
                                      description: Text(
                                        "Vous pourrez tres bientôt convertir vos pcc en jetons",
                                        textAlign: TextAlign.center,
                                      ),
                                    ));
                          });
                    }),
              ],
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            color: Colors.black,
          ),
          
         
          SizedBox(
            height: 20,
          ),
          // Divider(
          //   color: Colors.black,
          // ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.send,
                      color: Colors.black,
                      size: 35,
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Send Pcc",
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                        Text(
                          "Transferez vos pcc simplement",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey[400],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.send_to_mobile,
                    color: Colors.black,
                    size: 35,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          retrait = false;
                          return StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter mystate) =>
                                      NetworkGiffyDialog(
                                        buttonCancelText: Text("cool"),
                                        buttonOkText: Text(" _ "),
                                        image: Image(
                                            image: AssetImage(
                                                "assets/images/dev.jfif")),
                                        title: Text('En developpement',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.w600)),
                                        description: Text(
                                          "Vous pourrez tres bientôt Transferez vos pcc simplement",
                                          textAlign: TextAlign.center,
                                        ),
                                      ));
                        });
                  },
                )
              ],
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: 20,
          ),
        ],
      )),
    );
  }
}
