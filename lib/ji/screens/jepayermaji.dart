import 'package:flutter/material.dart';
import '../components.dart';
import '../globals.dart';
import '../styles.dart';

class JePayeMaJiPage extends StatefulWidget {
  const JePayeMaJiPage({key});

  @override
  State<JePayeMaJiPage> createState() => _JePayeMaJiPageState();
}

class _JePayeMaJiPageState extends State<JePayeMaJiPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kwhite,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: gblSize.height,
              color: kPrimaryColor.withOpacity(0.2),
              child: Center(
                child: Image.asset(
                  'assets/images/jipaye.jpg',
                  width: gblSize.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                  color: kwhite,
                  child: closeNavBar(context, "Payer ma JI", kPrimaryColor))),
        ],
      ),
    );
  }
}
