import 'package:flutter/material.dart';
import '../api.dart';
import '../components.dart';
import '../models/candidate.dart';
import '../models/competition.dart';
import '../screens/home.dart';

import '../styles.dart';

import '../globals.dart';
import '../utils.dart';

class CompetitionScreen extends StatefulWidget {
  const CompetitionScreen({key, this.competition});

  final Competition competition;

  @override
  State<CompetitionScreen> createState() => _CompetitionScreenState();
}

class _CompetitionScreenState extends State<CompetitionScreen> {
  @override
  void initState() {
    super.initState();

    Api.getCandidates(widget.competition.id).then((value) {
      setState(() {
        _candidates = value;
      });
    });
  }

  List<Candidate> _candidates = [];

  @override
  Widget build(BuildContext context) {
    List<Widget> candidatesCards = [];
    for (var candidate in _candidates) {
      candidatesCards.add(candidateCard(candidate));
    }

    return Scaffold(
        appBar:
            backNavBar(context, "${widget.competition.title}", kPrimaryColor),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                '$ipAddress${widget.competition.image}',
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: screenMargin,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.competition.title}",
                      style: h2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${widget.competition.description}",
                      style: paragraph,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: candidatesCards,
                ),
              ),
            ],
          ),
        ));
  }

  Widget candidateCard(Candidate candidate) {
    int quot = (widget.competition.voters.isEmpty)
        ? 1
        : widget.competition.voters.length;
    double percent = candidate.votes * 100 / quot;
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.network(
              '$ipAddress${candidate.image}',
              fit: BoxFit.cover,
              height: gblSize.width * 0.3,
              width: gblSize.width * 0.3,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace stackTrace) {
                return Image.asset(
                  'assets/images/not-found.png',
                  fit: BoxFit.cover,
                  height: gblSize.width * 0.3,
                  width: gblSize.width * 0.3,
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            width: gblSize.width - (50 + gblSize.width * 0.3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${candidate.name}",
                  style: blackBoldLabelStyle,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 5),
                  width: gblSize.width - (60 + gblSize.width * 0.3),
                  decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        width: 5,
                        decoration: BoxDecoration(
                            color: kPrimaryColor.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${noZero(percent)}% ",
                      style: blackBoldLabelStyle,
                    ),
                    if (globalUser != null)
                      if (!widget.competition.voters.contains(globalUser.id))
                        RectBtn(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        bordered: Border.all(color: Colors.black, width: 2),
                        label: const Text('VOTER', style: whiteButtonTextStyle),
                        bgColor: kwhite.withOpacity(0.1),
                        iconRight: const Icon(
                          Icons.arrow_forward,
                          size: 18,
                        ),
                        press: () {
                          Api.voteProject(widget.competition.id, candidate.id,
                                  globalUser.id)
                              .then((value) => {
                                   
                                        showSuccess("vote enregistré"),
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Home()))
                                    

                                    // setState(() {}
                                  });
                        },
                      )
                      
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
