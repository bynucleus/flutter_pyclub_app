import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pyclub/controller/mission_controller.dart';
import 'package:pyclub/model/mission.dart';
import 'package:pyclub/model/mission_model.dart';
import 'package:pyclub/services/http_service.dart';
import 'package:pyclub/util/constant.dart';
import 'package:pyclub/util/file_path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MissionPage extends StatefulWidget {
  const MissionPage({Key key}) : super(key: key);

  @override
  _MissionPageState createState() => _MissionPageState();
}

class _MissionPageState extends State<MissionPage> {
  // MissionController  missionController = Get.put(MissionController());
  List<Mission> _missions;
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMissions();
    setState(() {
      // print(missionController.fetchData());
    });
  }

  Future<void> getMissions() async {
    _missions = await API_Manager.getMissions();
    setState(() {
      _isLoading = false;
    });
  }

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
                // Text(
                //   'Une mission, un acquis !',
                //   style: Theme.of(context).textTheme.headline4,
                // ),
                const SizedBox(
                  height: 16,
                ),
                _contentOverView(),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Historique',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SvgPicture.asset(
                      filter,
                      color: Theme.of(context).iconTheme.color,
                      width: 18,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const SizedBox(
                  height: 30,
                ),
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : _contentServices(context, _missions)
                // missionController.isLoading.value
                //     ? Obx(()=>_contentServices(context, missionController.missionList))
                //     : Center(child: CircularProgressIndicator())
              ],
            ),
          ),
        ));
  }

  Widget _contentHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Image.asset(
              "assets/images/py_logo.png",
              width: 30, height: 30,
              // height: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              'pyMission',
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

  Widget _contentOverView() {
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 22, bottom: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor,
        // color: const Color(0xffF1F3F6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Une mission, un acquis !',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _contentServices(BuildContext context, List missionsList) {
  print("==========");
  print(missionsList.toString());
  return SizedBox(
    width: double.infinity,
    height: 400,
    child: GridView.count(
      crossAxisCount: 1,
      childAspectRatio: 4.10,
      children: missionsList.map((value) {
        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
                backgroundColor: Theme.of(context).cardColor,
                context: context,
                builder: (context) {
                  return Wrap(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                          child: ListTile(
                              leading: Icon(Icons.info),
                              title: Text(
                                "\nMission de classe " + value.classe,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700),
                              ))),

                      ListTile(
                        title: Text(
                          value.description,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      // ListTile(
                      //   title: Text("pour plus de detail telecharger le pdf"),
                      // ),
                      SizedBox(
                        height: 70,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            _launchURL(value.lien);
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            margin: EdgeInsets.only(bottom: 15, top: 25),
                            height: 50,
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Center(
                              child: Text(
                                'Telecharger le pdf',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xffFFAC30),
                              borderRadius: BorderRadius.circular(10),
                              // boxShadow: shadowList,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).cardColor,
                ),
                child: Text(
                  "Mission de classe " + value.classe,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
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
      }).toList(),
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
