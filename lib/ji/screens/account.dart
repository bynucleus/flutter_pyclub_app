import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../screens/home.dart';
import '../screens/login.dart';
import '../screens/mon_ticket.dart';
import '../screens/update_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';
import '../components.dart';
import '../globals.dart';
import '../styles.dart';

class Account extends StatefulWidget {
  const Account({key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  File _imageFile;
  List<String> files = [];
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (globalUser != null) {
      Api.retrieveUser(globalUser.id).then((value) => {setState(() {})});
    }
  }

  Future _getSelfie() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      Api.sendDocument(_imageFile.path).whenComplete(() => {
            Api.retrieveUser(globalUser.id).then((value) => {setState(() {})})
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return (globalUser != null)
        ? Scaffold(
            appBar: backNavBar(context, "Mon compte", kwhite),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(1),
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kPrimaryColor.withOpacity(0.2)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(200),
                                child: (globalUser.photo == null)
                                    ? Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Image.asset(
                                          'assets/images/user.png',
                                          width: gblSize.width * 0.20,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Image.network(
                                        '$ipAddress${globalUser.photo}',
                                        width: gblSize.width * 0.2 + 30,
                                        height: gblSize.width * 0.2 + 30,
                                        fit: BoxFit.cover,
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace stackTrace) {
                                          return Image.asset(
                                            'assets/images/user.png',
                                             width: gblSize.width * 0.2 + 30,
                                        height: gblSize.width * 0.2 + 30,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                              )),
                          SizedBox(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${globalUser.lastName}".toUpperCase(),
                                    style: h2,
                                  ),
                                  Text(
                                    "${globalUser.firstName}".toUpperCase(),
                                    style: h3,
                                  ),
                                  Text(
                                    "${globalUser.phoneNumber}".toUpperCase(),
                                    style: h3,
                                  ),
                                  Text(
                                    "${globalUser.level}".toUpperCase(),
                                    style: paragraph,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    child: RectBtn(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      bgColor: kwhite.withOpacity(0.2),
                                      bordered: Border.all(
                                          color: Colors.black, width: 1),
                                      iconRight: const Icon(
                                        Icons.arrow_forward_outlined,
                                        color: Colors.black,
                                      ),
                                      label: const Text(
                                        "MODIFIER MA PHOTO",
                                        style: whiteButtonTextStyle,
                                      ),
                                      press: () {
                                        _getSelfie();
                                      },
                                    ),
                                  ),
                                ]),
                          )
                        ],
                      )),
                  const Padding(
                    padding: screenMargin,
                    child: Divider(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: screenMargin,
                    child: SizedBox(
                      width: gblSize.width,
                      child: Column(
                        children: [
                          Container(
                            child: (!globalUser.paid)
                                ? jePayeMaJI(context)
                                : Column(
                                    children: [
                                      sectionTitle("Ticket d'entrée"),
                                      Image.asset(
                                        'assets/images/qr-code.png',
                                        width: gblSize.width * 0.35,
                                        fit: BoxFit.cover,
                                      ),
                                      Text(
                                        "".padRight(15, "#"),
                                        style: h2,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RectBtn(
                                          bgColor: Colors.black,
                                          label: const Text(
                                            "VOIR MON CODE D'INVITATION",
                                            style: primaryButtonTextStyle,
                                          ),
                                          press: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MonTicket()),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                          const Divider(),
                          OptionCard(
                            label: "MODIFIER MES INFO.",
                            tap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const UpdateInfo()),
                              );
                            },
                          ),
                          // OptionCard(
                          //   label: "DECONNEXION",
                          //   tap: () {
                          //     print("Ok");
                          //   },
                          // ),
                          OptionCard(
                            label: "DECONNEXION",
                            image: 'assets/images/logout.png',
                            tap: () async {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              await preferences.clear();
                              globalUser = null;
                              gbltoken = '';
                              showSuccess("utilisateur déconnecté");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : const Login();
  }
}
