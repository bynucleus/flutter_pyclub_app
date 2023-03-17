
import 'package:flutter/material.dart';
import 'screens/account.dart';
import 'screens/activities.dart';
import 'screens/home.dart';
import 'screens/onboarding.dart';
import 'styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart';

class JiApp extends StatefulWidget {
  const JiApp({key});

  @override
  State<JiApp> createState() => _MyAppState();
}

class _MyAppState extends State<JiApp> {
  bool _loading = true;
  Widget _toShow = Container(color: kwhite, child: Center(child: loader()));

  _loadPref() async {
    loadData();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Widget home = const Onboarding();
    bool notfistTime = (prefs.getBool('notFistTime') ?? false);
    if (notfistTime) {
      home = const Home();
    }

    setState(() {
      _toShow = home;
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPref();
    _toShow = Container(color: kwhite, child: Center(child: loader()));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ji_2023',
      theme: ThemeData(
        primarySwatch: white,
      ),
      home: _toShow,
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({key});

  @override
  State<StatefulWidget> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>
    with SingleTickerProviderStateMixin {
   TabController _tabController;

  static const _kTabPages = <Widget>[Activities(), Home(), Account()];
  static const _kTabs = <Tab>[
    Tab(
        icon: Icon(
          Icons.calendar_month,
          color: kTextColor,
        ),
        text: 'Activités'),
    Tab(icon: Icon(Icons.home, color: kTextColor), text: 'Acceuil'),
    Tab(
        icon: Icon(Icons.account_circle_outlined, color: kTextColor),
        text: 'Mon compte'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _kTabPages.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    gblSize = MediaQuery.of(context).size;
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: _kTabPages,
      ),
      bottomNavigationBar: Material(
        color: kwhite,
        child: TabBar(
          labelColor: kTextColor,
          indicatorWeight: 3.0,
          indicatorColor: kPrimaryColor,
          tabs: _kTabs,
          controller: _tabController,
        ),
      ),
    );
  }
}
