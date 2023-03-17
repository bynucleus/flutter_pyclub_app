import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components.dart';
import '../globals.dart';
import '../styles.dart';
import 'home.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({
    Key key,
  }) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  String titleText = 'JOURNÉE D\' INTÉGRATION 2023';

  List imagesSlider = [
    {'imageSrc': 'assets/images/bg1.jpg'},
    {'imageSrc': 'assets/images/JI-2022.jpg'},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    gblSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kwhite,
      body: Container(
        color: ksecondaryColor.withOpacity(0.4),
        height: gblSize.height,
        width: gblSize.width,
        child: Stack(children: [
          Positioned(
              top: 0,
              bottom: gblSize.height * 0.15,
              left: 0,
              right: 0,
              child: Container(
                height: gblSize.height,
                width: gblSize.width,
                child: Center(
                  child: Image.asset(
                    'assets/images/background.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      child: Container(
                        child: Text(titleText,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Container(
                        child: Text(
                            '"La polyvalence du miagiste en milieu professionnel"',
                            style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 20,
                                fontStyle: FontStyle.italic),
                            textAlign: TextAlign.center),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: gblSize.width * 0.5 - 10,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 5),
                            child: RectBtn(
                              label: const Text('CONNEXION',
                                  style: btnblackTextStyle),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 5),
                              bordered:
                                  Border.all(color: Colors.black, width: 1.3),
                              bgColor: kwhite.withOpacity(0),
                              press: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setBool('notFistTime', true);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()),
                                );
                              },
                            )),
                        Container(
                            width: gblSize.width * 0.5 - 10,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 5),
                            child: RectBtn(
                              label: const Text('DEMARRER',
                                  style: btnWhiteTextStyle),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 5),
                              bgColor: Colors.black,
                              bordered: Border.all(color: Colors.black),
                              iconRight: Icon(
                                Icons.arrow_forward,
                                color: kwhite,
                                size: 17,
                              ),
                              press: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setBool('notFistTime', true);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Home()),
                                );
                              },
                            )),
                      ],
                    ),
                  ],
                ),
              ))
        ]),
      ),
    );
  }
}
