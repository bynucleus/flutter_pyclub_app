import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myclub/ji/main.dart';
import 'package:myclub/ui/screen/sign_in.dart';
import 'package:myclub/util/file_path.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'drawer_page.dart';
import 'login.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  static DateTime now = DateTime.now();
  bool isAuth = false;

  String formattedTime = DateFormat.jm().format(now);
  String formattedDate = "";


  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      setState(() {
        isAuth = true;
      });
    }
  }
  
  @override
  void initState() {
    initializeDateFormatting();
    _checkIfLoggedIn();

    super.initState();
    setState(() {
      formattedDate = DateFormat.yMMMMd("fr_FR").format(now);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
           
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _topContent(),
                      _centerContent(),
                      _bottomContent()
                    ],
                  ),
                ),
              ),
            ),
             Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: SvgPicture.asset(mainBanner),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        const SizedBox(
          height: 18,
        ),
        Center(child:  Image.asset(
            'assets/images/ji.png',
            width: 100.0,
            height: 60.0,
            fit: BoxFit.cover,
          ),),
       Center(child: Text(
              'JI MIAGE 2023',
              textAlign : TextAlign.end,
              style: Theme.of(context).textTheme.subtitle1,
            ),),
        const SizedBox(
          height: 22,
        ),
        // Text(
        //   formattedDate,
        //   style: Theme.of(context).textTheme.bodyText2,
        // )
      ],
    );
  }

  Widget _centerContent() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
         
          // SvgPicture.asset(logo),
          const SizedBox(
            height: 1,
          ),
          // Text(
          //   'yClub',
          //   style: Theme.of(context).textTheme.headline5,
          // ),
          const SizedBox(
            height: 1,
          ),
          Text(
            "Journée d'intégration MIAGE 2023 CAISTAB PLATEAU,",
              textAlign : TextAlign.end,

            style: Theme.of(context).textTheme.bodyText2,
          ),
          Text(
            "la legende de la caverne du savoir continue...",
              textAlign : TextAlign.end,

            style: Theme.of(context).textTheme.bodyText2,
          ),
            const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget _bottomContent() {
    return Column(
      children: <Widget>[
        MaterialButton(
          elevation: 0,
          color: const Color(0xFFFFAC30),
          height: 50,
          minWidth: 200,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JiApp()
                // const DrawerPage(),
              ),
            );
          },
          child: Text(
            'Continuer vers la JI',
            style: Theme.of(context).textTheme.button,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        GestureDetector(
          child: Text(
            'Espace club MIAGE',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => isAuth ? DrawerPage() : SignInPage(),
                // const DrawerPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}
