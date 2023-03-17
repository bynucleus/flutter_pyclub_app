import 'package:flutter/material.dart';
import '../components.dart';
import '../models/competition.dart';
import '../models/news.dart';
import '../screens/activities.dart';
import '../screens/competition.dart';
import '../screens/panel.dart';
import '../screens/read_news.dart';
import '../screens/restauration.dart';

import '../api.dart';
import '../globals.dart';
import '../styles.dart';
import '../utils.dart';

class Home extends StatefulWidget {
  const Home({key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Api.getNews().then((value) {
      setState(() {
        _news = value;
      });
    });
    Api.getCompetitions().then((value) {
      setState(() {
        _allCompetitions = value;
      });
    });
    Api.getRooms().then((value) {
      setState(() {
        _allRooms = value;
      });
    });
  }

  List<News> _news = [];
  List<Competition> _allCompetitions = [];
  List _allRooms = [];

  List imagesSlider = [
    {'imageSrc': 'assets/images/bg1.jpg'},
    {'imageSrc': 'assets/images/JI-2022.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    gblSize = MediaQuery.of(context).size;
    List<Widget> newsCards = [];
    List<Widget> roomCards = [];
    for (var newObj in _news) {
      newsCards.add(newsCard(newObj, context));
    }
    for (var room in _allRooms) {
      roomCards.add(panelCard(room, context));
    }
    String prenom =
        (globalUser != null) ? globalUser.firstName.split(' ').last : "";
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: navBar(context, "Hello $prenom"),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  menuItem("assets/images/agenda.png", "PROGRAMME\nD'ACTIVITÉ",
                      false, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Activities()),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: menuItem(
                        "assets/images/restau.jpg", "RESTAURATION", false, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Restauration()),
                      );
                    }),
                  ),
                ],
              ),
              Column(
                children: roomCards,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 5),
                child: DateCountdown(targetDate: DateTime.parse("2023-03-18")),
              ),
              const Divider(),
              jePayeMaJI(context),
              const SizedBox(
                height: 25,
              ),
              if (!_allCompetitions.isEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Text("Compétitions".toUpperCase(), style: h2),
                    ),
                    competitionList(_allCompetitions, const SizedBox()),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Text("Actualités".toUpperCase(), style: h2),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                child: Column(
                  children: newsCards,
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget competitionList(
  List<Competition> allcompetition,
  Widget empty,
) {
  return Container(
    margin: screenMargin,
    height: 225,
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: allcompetition.length,
        itemBuilder: (context, index) {
          return competitionCard(context, allcompetition[index]);
        }),
  );
}

Widget panelCard(dynamic data, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Panel(room: data['_id'])),
      );
    },
    child:Container(
  margin: screenMargin,
  padding: const EdgeInsets.all(10),
  decoration: BoxDecoration(
    border: Border.all(color: Colors.black),
    borderRadius: BorderRadius.circular(5),
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${data['label']}",
              style: blackBoldLabelStyle,
            ),
            Text("${data['title']}", style: minLabelStyle),
          ],
        ),
      ),
      const Icon(Icons.arrow_forward_ios_outlined),
    ],
  ),
)

  );
}

Widget competitionCard(BuildContext context, Competition competition) {
  const nameStyle =
      TextStyle(fontSize: 20, color: kwhite, fontWeight: FontWeight.bold);
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CompetitionScreen(competition: competition)),
      );
    },
    child: Container(
        margin: const EdgeInsets.only(right: 12),
        height: (gblSize.width * 0.6),
        width: gblSize.width * 0.9,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              '$ipAddress${competition.image}',
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Container(
          padding: const EdgeInsets.only(bottom: 15, right: 10, left: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.black.withOpacity(0.45),
          ),
          child: Center(
              child: Text(competition.title.toUpperCase(), style: nameStyle)),
        )),
  );
}

Widget newsCard(News news, BuildContext context) {
  const newstitleStyle =
      TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold);

  return Container(
    margin: const EdgeInsets.only(bottom: 10, top: 5),
    padding: const EdgeInsets.all(7),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: ksecondaryColor.withOpacity(0.0)),
    // width: gblSize!.width - 30,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            // border: Border.all(color: kPrimaryColor, width: 1.5)
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.network(
              '$ipAddress${news.image}',
              fit: BoxFit.cover,
              height: 200,
              width: gblSize.width,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace stackTrace) {
                return Image.asset(
                  'assets/images/not-found.png',
                  fit: BoxFit.cover,
                  height: 200,
                  width: gblSize.width,
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                threeDot("${news.title}", 20),
                style: newstitleStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                threeDot("${news.description}", 60),
                style: paragraph,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: gblSize.width * 0.45,
                  child: RectBtn(
                    bordered: Border.all(color: Colors.black, width: 2),
                    label: const Text('LIRE PLUS', style: whiteButtonTextStyle),
                    bgColor: kwhite.withOpacity(0.1),
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReadNews(news: news)),
                      );
                    },
                  )),
            ],
          ),
        ),
      ],
    ),
  );
}
