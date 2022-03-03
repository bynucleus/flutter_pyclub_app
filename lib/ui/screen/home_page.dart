import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:pyclub/model/seance.dart';
import 'package:pyclub/model/user.dart';
import 'package:pyclub/services/http_service.dart';
import 'package:pyclub/ui/widgets/custom_w1.dart';
import 'package:pyclub/util/constant.dart';
import 'package:pyclub/util/file_path.dart';
import 'package:pyclub/util/info.dart';

import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final databaseRef = FirebaseDatabase.instance.reference();
  List<UserM> _users;
  List<SeanceModel> _seances;
  bool _isLoadingUserList = true;
  bool _isLoadingSeanceList = true;
  String pcc ;
  Widget buildMovieShimmer() => CustomWidget.rectangular(width: 80);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    setState(() {
      // print(missionController.fetchData());
    });
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

  Future<void> getData() async {
    setState(() {
      pcc=Info.pcc;
      _isLoadingUserList = true;
      _isLoadingSeanceList = true;
    });
    _users = await API_Manager.getUsers();
    _seances = await API_Manager.getSeances();

    setState(() {
       pcc=Info.pcc;
      _isLoadingUserList = false;
      _isLoadingSeanceList = false;
    });
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    // monitor network fetch
    print("ok");
    await getData();
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    _refreshController.refreshCompleted();
  }

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
                  Text(
                    'Progression',
                    style: Theme.of(context).textTheme.headline4,
                  ),
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
                        'Autres membres',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SvgPicture.asset(
                        recive,
                        color: Theme.of(context).iconTheme.color,
                        width: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _isLoadingUserList
                      ? Center(child: CircularProgressIndicator())
                      : _contentSendMoney(context, _users),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Seances',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      SvgPicture.asset(
                        filter,
                        color: Theme.of(context).iconTheme.color,
                        width: 18,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  _isLoadingSeanceList
                      ? Center(child: CircularProgressIndicator())
                      : _contentServices(context, _seances),
                ],
              ),
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
            // SvgPicture.asset(
            //   logo,
            //   width: 34,
            // ),
            Image.asset(
              "assets/images/py_logo.png",
              width: 30, height: 30,
              // height: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              'pyClub',
              style: Theme.of(context).textTheme.headline3,
            )
          ],
        ),
        InkWell(
          onTap: () {
            setState(() {
              print('call');
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
                pcc ?? '' + ' pcc',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                getNiveau(int.parse(Info.pcc ?? "1")),
                style: Theme.of(context).textTheme.headline4.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
              )
            ],
          ),
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: const Color(0xffFFAC30),
              borderRadius: BorderRadius.circular(80),
            ),
            child: const Center(
              child: Icon(
                Icons.verified,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contentSendMoney(BuildContext context, List list) {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            width: 80,
            padding: const EdgeInsets.only(
              left: 18,
              right: 18,
              top: 28,
              bottom: 28,
            ),
            child: Container(
              height: 10,
              width: 10,
              decoration: const BoxDecoration(
                color: Color(0xffFFAC30),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(Icons.person),
              ),
            ),
          ),
          for (var item in list)
            Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(16),
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).cardColor,
              ),
              child: GestureDetector(
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
                                      // leading: Icon(Icons.info),
                                      title: Text(
                                "\nInfo Membre ",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700),
                              ))),

                              ListTile(
                                trailing: Text(
                                  item.name + " " + item.prenom,
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                title: Text("Nom"),
                              ),
                              // ListTile(
                              //   title: Text("pour plus de detail telecharger le pdf"),
                              // ),
                              SizedBox(
                                height: 5,
                              ),

                              ListTile(
                                trailing: Text(
                                  item.email,
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                title: Text("Email"),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              ListTile(
                                trailing: Text(
                                  item.pcc + " pcc",
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                title: Text("Point"),
                              ),
                              ListTile(
                                trailing: Text(
                                  item.niveau,
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                title: Text("niveau"),
                              ),
                            ],
                          );
                        });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: const Color(0xffD8D9E4))),
                        child: CircleAvatar(
                          radius: 22.0,
                          backgroundColor: Theme.of(context).backgroundColor,
                          child: ClipRRect(
                            child: SvgPicture.asset(
                                getProfile(item?.profileImage)),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      ),
                      Flexible(
                          child: Text(
                        item.name ?? " ",
                        style: Theme.of(context).textTheme.bodyText1,
                      ))
                    ],
                  )),
            ),
        ],
      ),
    );
  }

  getProfile(String p) {
    if (p == "avator1.svg")
      return avatorOne;
    else if (p == "avator2.svg")
      return avatorTwo;
    else if (p == "avator3.svg")
      return avatorThree;
    else
      return avatorTwo;
  }

  Widget _contentServices(BuildContext context, List list) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: GridView.count(
        crossAxisCount: 1,
        childAspectRatio: 4.10,
        children: list.map((value) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => DetailPage(value)));
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
                    "Seance du " + value.date,
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
}

class ModelServices {
  String title, img;
  ModelServices({this.title, this.img});
}
