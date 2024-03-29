import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pyclub/util/file_path.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'login.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  static DateTime now = DateTime.now();

  String formattedTime = DateFormat.jm().format(now);
  String formattedDate = "";

  @override
  void initState() {
    initializeDateFormatting();
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
              flex: 1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: SvgPicture.asset(mainBanner),
              ),
            ),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _topContent(),
                    _centerContent(),
                    _bottomContent()
                  ],
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 18,
        ),
        Row(
          children: <Widget>[
            Text(
              'MIAGE',
              style: Theme.of(context).textTheme.subtitle1,
            ),

            // Text(
            //   formattedTime,
            //   style: Theme.of(context).textTheme.headline6,
            // ),
            // const SizedBox(
            //   width: 30,
            // ),

            // SvgPicture.asset(electricity),
            // const SizedBox(
            //   width: 8,
            // ),
          ],
        ),
        const SizedBox(
          height: 22,
        ),
        Text(
          formattedDate,
          style: Theme.of(context).textTheme.bodyText2,
        )
      ],
    );
  }

  Widget _centerContent() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            'assets/images/py_logo.png',
            width: 40.0,
            height: 40.0,
            fit: BoxFit.cover,
          ),
          // SvgPicture.asset(logo),
          const SizedBox(
            height: 1,
          ),
          Text(
            'pyClub',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(
            height: 18,
          ),
          Text(
            'pyClub est exclusivement reservé aux membres du club python de la filière Miage de l\'université FHB.\n',
            style: Theme.of(context).textTheme.bodyText1,
          )
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
                builder: (context) => AuthPage(
                  register: false,
                ),
                // const DrawerPage(),
              ),
            );
          },
          child: Text(
            'Connexion',
            style: Theme.of(context).textTheme.button,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        GestureDetector(
          child: Text(
            'Créer un compte',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AuthPage(
                  register: true,
                ),
                // const DrawerPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}
