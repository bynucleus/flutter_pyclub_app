import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:myclub/controller/mission_controller.dart';
import 'package:myclub/model/mission.dart';
import 'package:myclub/model/mission_model.dart';
import 'package:myclub/services/http_service.dart';
import 'package:myclub/util/constant.dart';
import 'package:myclub/util/file_path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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
  BannerAd myBanner;
  bool isloaded = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    myBanner = BannerAd(
      adUnitId: 'ca-app-pub-5121228300622251/7582962653',
      // adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {
          setState(() {
            isloaded = true;
          });
          print('Ad loaded.');
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          print('Ad failed to load: $error');
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => print('Ad opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) => print('Ad closed.'),
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) => print('Ad impression.'),
      ),
    );

    myBanner.load();
  }

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

  void _onRefresh() async {
    // monitor network fetch
    print("ok");
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    await getMissions();
    setState(() {
      _isLoading = false;
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    print("odd");

    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    await getMissions();
    // _ressource = await API_Manager.getRessources();
    setState(() {
      _isLoading = false;
    });
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  /// Create a controller
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropHeader(),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = Text("pull up load");
                } else if (mode == LoadStatus.loading) {
                  body = CupertinoActivityIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = Text("Load Failed!Click retry!");
                } else if (mode == LoadStatus.canLoading) {
                  body = Text("release to load more");
                } else {
                  body = Text("No more Data");
                }
                return Container(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            controller: _refreshController,
            onRefresh: _onRefresh,
            // onLoading: _onLoading,
            child: Padding(
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
                        : _contentServices(context, _missions),

                    isloaded
                        ? Container(
                            height: 50,
                            child: AdWidget(
                              ad: myBanner,
                            ))
                        : SizedBox(),
                    // missionController.isLoading.value
                    //     ? Obx(()=>_contentServices(context, missionController.missionList))
                    //     : Center(child: CircularProgressIndicator())
                  ],
                ),
              ),
            )));
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
              'Missions',
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
    height: 430,
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
                            _launchURL(URL_BASE+value.lien);
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
