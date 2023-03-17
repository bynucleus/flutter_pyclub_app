import 'package:flutter/material.dart';
import '../api.dart';
import '../components.dart';

import '../models/news.dart';
import '../styles.dart';



class ReadNews extends StatefulWidget {
  const ReadNews({key, this.news});

  final News news;

  @override
  State<ReadNews> createState() => _ReadNewsState();
}

class _ReadNewsState extends State<ReadNews> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: backNavBar(context, "${widget.news.title}", kPrimaryColor),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                '$ipAddress${widget.news.image}',
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                  StackTrace stackTrace) {
                return Image.asset(
                  'assets/images/not-found.png',
                  fit: BoxFit.cover,
                  
                );
              },
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
                      "${widget.news.title}",
                      style: h2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${widget.news.description}",
                      style: paragraph,
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
