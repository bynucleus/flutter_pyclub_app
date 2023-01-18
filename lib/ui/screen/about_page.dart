import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myclub/util/file_path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Wrap(children: [
                // SizedBox(
                //   height: 50,
                // ),
                Image.asset(
                  "assets/images/myclub.png",
                  // "assets/images/pyclub.png",
                  height: MediaQuery.of(context).size.width / 2,
                ),
                // Text("about"),

                ListTile(
                  leading: Icon(Icons.verified),
                  title: Text("version"),
                  trailing: Text("1.1.2 "),
                ),
                ListTile(
                  leading: Icon(Icons.supervised_user_circle),
                  title: Text("auteur"),
                  trailing: GestureDetector(
                      onTap: () async {
                        if (await canLaunch("http://nucleus.studio")) {
                          await launch("http://nucleus.studio");
                        } else {
                          Fluttertoast.showToast(
                              msg: "impossible d'ouvrir le lien : " +
                                  "http://nucleus.studio");
                          // throw 'Could not launch link';
                        }
                      },
                      child: Text(
                        "@nucleus",
                        style: TextStyle(color: Colors.blue),
                      )),
                ),
                SizedBox(
                  height: 300,
                ),
                Center(
                    child: Text(
                  "\ncroyez en Dieu et croyez en vous ! ",
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700),
                )),
                Center(
                    child: Text(
                  "\nCopyright ©2023 Nucleus, Tous droits réservés ! ! ",
                  style: TextStyle(
                    fontSize: 10.0,
                  ),
                )),
              ])
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
              'a Propos ',
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

class ModelServices {
  String title, img;
  ModelServices({this.title, this.img});
}
