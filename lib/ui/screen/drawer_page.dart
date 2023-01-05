import 'package:dart_eval/dart_eval.dart';
import 'package:flutter/cupertino.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:myclub/model/user.dart';
import 'package:myclub/model/user_model.dart';
import 'package:myclub/services/http_service.dart';
import 'package:myclub/ui/screen/about_page.dart';
import 'package:myclub/ui/screen/home_page.dart';
import 'package:myclub/ui/screen/liste.dart';
import 'package:myclub/ui/screen/member_page.dart';
import 'package:myclub/ui/screen/profile.dart';
import 'package:myclub/ui/screen/ressource_page.dart';
import 'package:myclub/ui/screen/sign_in.dart';
import 'package:myclub/util/network_bloc.dart';
import 'package:myclub/util/network_event.dart';
import 'package:myclub/util/constant.dart';
import 'package:myclub/util/file_path.dart';
import 'package:myclub/util/info.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:select_dialog/select_dialog.dart';
import 'mission_page.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key key}) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> with TickerProviderStateMixin {
  bool sideBarActive = false;
  bool home = true;
  bool about = false;
  bool mission = false;
  bool ressource = false;
  bool profile = false;
  bool progression = false;
  int _index = 0;
  // final BannerAdListener listener =

  // User user;
  final parser = Parse();
  UserModel userModel;
  // DatabaseReference userRef;
  UserM _user;
  String _verifAdmin = "sminth@sminth.com";
  bool _isLoadingUser = true;
  var profileImage = null;
  List pages = [
    HomePage(),
    const MissionPage(),
    const RessourcePage(),
    const MemberPage(),
    ProfilePage(),
    const AboutPage()
  ];

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

  // _getUserDetails() async {
  //   DatabaseEvent snapshot = (await userRef.once());
  //   print(snapshot.snapshot.value);
  //   userModel =
  //       UserModel.fromMap(Map<String, dynamic>.from(snapshot.snapshot.value));
  //   // print(userModel.email);
  //   setState(() {});
  // }
  AdWidget adWidget;
  AnimationController rotationController;



  @override
  void initState() {
   
    // adWidget = AdWidget(ad: myBanner);

    rotationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    super.initState();

    // user = FirebaseAuth.instance.currentUser;
    getUserDetails();
    // if (user != null) {
    //   userRef =
    //       FirebaseDatabase.instance.reference().child('users').child(user.uid);
    // }
    // _getUserDetails();
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
      profileImage = "assets/svg/" + _user?.profileImage;
      _isLoadingUser = false;
      _verifAdmin = _user?.email;
    });
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    // monitor network fetch
    print("ok");
    await getUserDetails();
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).cardColor,
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
          child: BlocProvider(
            create: (context) => NetworkBloc()..add(ListenConnection()),
            child: Stack(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(60)),
                              color: Theme.of(context).backgroundColor),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
//                                Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (_) => ProfilePage()));

                                    SelectDialog.showModal<String>(
                                      context,
                                      label: "Selectionner un nouvel avatar",
                                      // selectedValue: ex1,
                                      showSearchBox: false,
                                      alwaysShowScrollBar: false,
                                      items: List.generate(
                                          17, (index) => "${index + 1}"),
                                      itemBuilder: (BuildContext context,
                                          String h, bool isSelected) {
                                        return Container(
                                          decoration: !isSelected
                                              ? null
                                              : BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                          child: ListTile(
                                            leading: Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: const Color(
                                                          0xffD8D9E4))),
                                              child: CircleAvatar(
                                                radius: 22.0,
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .backgroundColor,
                                                child: ClipRRect(
                                                  child: SvgPicture.asset(
                                                      "assets/svg/avator$h.svg"),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                ),
                                              ),
                                            ),
                                            selected: isSelected,
                                            title: Text(avatarName(h)),
                                            // subtitle: Text(item.createdAt.toString()),
                                          ),
                                        );
                                      },
                                      onChange: (String selected) {
                                        setState(() {
                                          changeAvatar(selected);
                                        });
                                      },
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(
                                            color: const Color(0xffD8D9E4))),
                                    child: CircleAvatar(
                                      radius: 22.0,
                                      backgroundColor:
                                          Theme.of(context).backgroundColor,
                                      child: ClipRRect(
                                        // SvgPicture
                                        // child: SvgPicture.asset(avatorThree),
                                        child: SvgPicture.asset(
                                            profileImage != null
                                                ? profileImage
                                                : "assets/svg/avator1.svg"),

                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                _isLoadingUser
                                    ? Center(child: CircularProgressIndicator())
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              _user?.name ?? "myclub",
                                              // userModel.email,
                                              // "f",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                          ),
                                          Flexible(
                                              child: Text(
                                            _user?.email ?? " ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          )),
                                        ],
                                      )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: navigatorTitle("Home", home),
                            onTap: () {
                              setState(() {
                                _index = 0;
                                home = true;
                                about = false;
                                profile = false;
                                mission = false;
                                progression = false;
                                ressource = false;
                              });
                            },
                          ),
                          GestureDetector(
                            child: navigatorTitle("Missions", mission),
                            onTap: () {
                              setState(() {
                                _index = 1;
                                home = false;
                                profile = false;
                                about = false;
                                progression = false;
                                mission = true;
                                ressource = false;
                              });
                            },
                          ),
                          GestureDetector(
                            child: navigatorTitle("Ressources", ressource),
                            onTap: () {
                              setState(() {
                                _index = 2;
                                profile = false;
                                home = false;
                                progression = false;
                                about = false;
                                mission = false;
                                ressource = true;
                              });
                            },
                          ),
                          _verifAdmin == "anelda@gmail.com"
                              ? GestureDetector(
                                  child:
                                      navigatorTitle("Parametre", progression),
                                  onTap: () {
                                    setState(() {
                                      _index = 3;
                                      progression = true;
                                      home = false;
                                      profile = false;
                                      about = false;
                                      mission = false;
                                      ressource = false;
                                    });
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (_) => MemberPage()));
                                  },
                                )
                              : Container(),
                          //
                          GestureDetector(
                            child: navigatorTitle("Profile", profile),
                            onTap: () {
                              setState(() {
                                _index = 4;
                                home = false;
                                progression = false;
                                profile = true;

                                about = false;
                                mission = false;
                                ressource = false;
                              });
                            },
                          ),

                          GestureDetector(
                            child: navigatorTitle("A propos", about),
                            onTap: () {
                              setState(() {
                                _index = 5;
                                home = false;
                                progression = false;
                                profile = false;

                                about = true;
                                mission = false;
                                ressource = false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                   

                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.power_settings_new,
                            size: 24,
                            color: Theme.of(context).iconTheme.color,
                            // color: sideBarActive ? Colors.black : Colors.white,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            child: Text(
                              "Deconnexion",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            onTap: () async {
                              SharedPreferences localStorage =
                                  await SharedPreferences.getInstance();
                              localStorage.remove("user");
                              localStorage.remove("token");
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
// Here you can write your code

                                setState(() {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => SignInPage()),
                                      (route) => false);
                                });
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.all(20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //
                              GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: const Duration(seconds: 2),
                                        backgroundColor:
                                            lightTheme.backgroundColor,
                                        content: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                          child: Center(
                                            child: Text("Jésus t'aime !",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "hora et labora !",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  )),
                              _verifAdmin == "anelda@gmail.com"
                                  ? IconButton(
                                      icon: Icon(Icons.list_sharp),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => ListePage()));
                                        Fluttertoast.showToast(msg: "okf");
                                        setState(() {});
                                      },
                                    )
                                  : Container(),
                              IconButton(
                                icon: Icon(Icons.refresh),
                                onPressed: () {
                                  getUserDetails();
                                  Fluttertoast.showToast(msg: "ok");
                                  setState(() {});
                                },
                              ),
                            ]))
                  ],
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  left: (sideBarActive)
                      ? MediaQuery.of(context).size.width * 0.6
                      : 0,
                  top: (sideBarActive)
                      ? MediaQuery.of(context).size.height * 0.2
                      : 0,
                  child: RotationTransition(
                    turns: (sideBarActive)
                        ? Tween(begin: -0.05, end: 0.0)
                            .animate(rotationController)
                        : Tween(begin: 0.0, end: -0.05)
                            .animate(rotationController),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: (sideBarActive)
                          ? MediaQuery.of(context).size.height * 0.7
                          : MediaQuery.of(context).size.height,
                      width: (sideBarActive)
                          ? MediaQuery.of(context).size.width * 0.8
                          : MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: sideBarActive
                            ? const BorderRadius.all(Radius.circular(40))
                            : const BorderRadius.all(Radius.circular(0)),
                        color: Colors.white,
                      ),
                      child: ClipRRect(
                        borderRadius: sideBarActive
                            ? const BorderRadius.all(Radius.circular(40))
                            : const BorderRadius.all(Radius.circular(0)),
                        child: pages[_index],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 20,
                  child: (sideBarActive)
                      ? IconButton(
                          padding: const EdgeInsets.all(30),
                          onPressed: closeSideBar,
                          icon: Icon(
                            Icons.close,
                            color: Theme.of(context).iconTheme.color,
                            size: 30,
                          ),
                        )
                      : InkWell(
                          onTap: openSideBar,
                          child: Container(
                            margin: const EdgeInsets.all(17),
                            height: 30,
                            width: 30,
                          ),
                        ),
                )
              ],
            ),
          ),
        ));
  }

  Row navigatorTitle(
    String name,
    bool isSelected,
  ) {
    return Row(
      children: [
        (isSelected)
            ? Container(
                width: 5,
                height: 40,
                color: const Color(0xffffac30),
              )
            : const SizedBox(
                width: 5,
                height: 40,
              ),
        const SizedBox(
          width: 10,
          height: 45,
        ),
        Text(
          name,
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontSize: 16,
                fontWeight: (isSelected) ? FontWeight.w700 : FontWeight.w400,
              ),
        ),
      ],
    );
  }

  void closeSideBar() {
    sideBarActive = false;
    setState(() {});
  }

  void openSideBar() {
    sideBarActive = true;
    setState(() {});
  }

  void changeAvatar(String selected) {
    API_Manager.setAvatar(_user.id, "avator$selected.svg");
    getUserDetails();
    Fluttertoast.showToast(msg: "nouvel avatar");
  }
}

String avatarName(String h) {
  switch (h) {
    case "10":
      return "junior avatar";
      break;
    case "2":
      return "bryan avatar";
      break;
    case "8":
      return "amenan avatar";
      break;
    case "4":
      return "lolipop avatar";
      break;
    case "5":
      return "domi avatar";
      break;
    case "15":
      return "bedel avatar";
      break;
    case "1":
      return "gumball avatar";
      break;
    case "17":
      return "last avatar";
      break;
    default:
      return "avatar $h";
      break;
  }
}
