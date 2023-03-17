import 'package:flutter/material.dart';
import '../globals.dart';
import '../models/others.dart';
import '../styles.dart';

import '../api.dart';
import '../components.dart';

class Activities extends StatefulWidget {
  const Activities({key});

  @override
  State<Activities> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  @override
  void initState() {
    super.initState();
    Api.getActivities().then((value) {
      setState(() {
        _activities = value;
      });
    });
  }

  List<Activity> _activities = [];

  @override
  Widget build(BuildContext context) {
    List<Widget> activityCards = [];
    for (var activity in _activities) {
      activityCards.add(activityCard(context, activity, const Divider()));
    }
    return Scaffold(
      appBar: backNavBar(context, "Programme d'activité", kPrimaryColor),
      backgroundColor: kwhite,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Container(
            // constraints: BoxConstraints(maxHeight: gblSize.height),
            // color: kPrimaryColor.withOpacity(0.2),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Column(
                children: 
               
                activityCards,
              ),
            
          )
        ]),
      ),
    );
  }
}
