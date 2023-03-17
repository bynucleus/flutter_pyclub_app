// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myclub/ji/main.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:myclub/ui/screen/drawer_page.dart';
import 'package:myclub/ui/screen/intro.dart';
import 'package:myclub/ui/screen/sign_in.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ji/globals.dart';
import 'ji/styles.dart';
import 'util/constant.dart';
import 'util/theme.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
MobileAds.instance.initialize();
  // await Firebase.initializeApp();

  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   systemNavigationBarColor: LightColors.kLightYellow, // navigation bar color
  //   statusBarColor: Color(0xffffb969), // status bar color
  // ));

  return runApp(MyApp());
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isAuth = false;
    bool _loading = true;
  Widget _toShow = Container(color: Colors.white, child: Center(child: loader()));

  _loadPref() async {
    loadData();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Widget home = const IntroPage();
    bool notfistTime = (prefs.getBool('notFistTime') ?? false);
    if (notfistTime) {
      home = const JiApp();
    }

    setState(() {
      _toShow = home;
      _loading = false;
    });
  }
  @override
  void initState() {
    // FirebaseAuth.instance.currentUser;
    _loadPref();
    _toShow = Container(color: Colors.white, child: Center(child: loader()));
    
    _themeManager.addListener(themeListener);
    super.initState();
  }

  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

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
  Widget build(BuildContext context) {
    return MaterialApp(
      // routes: <String, WidgetBuilder>{
      //   '/loginPage': (BuildContext context) => new SignInPage(),
      //   '/home': (BuildContext context) => new DrawerPage(),
      // },
      title: 'myClub',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      // theme: darkTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: SplashScreenView(
        // navigateRoute: JiApp(),
        navigateRoute: _toShow,
        // navigateRoute: isAuth ? DrawerPage() : SignInPage(),
        duration: 3000,
        // imageSize: 230,
        imageSize: 60,
        imageSrc: "assets/images/myclub.png",
        // imageSrc: "assets/images/pyclub.png",
        text: "l'art de coder !",
        textType: TextType.TyperAnimatedText,
        textStyle: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
        backgroundColor: COLOR_BACKGROUND_LIGHT,
      ),
    );
  }
}
