import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../components.dart';
import '../globals.dart';
import '../styles.dart';

class MonTicket extends StatefulWidget {
  const MonTicket({key});

  @override
  State<MonTicket> createState() => _MonTicketState();
}

class _MonTicketState extends State<MonTicket> {
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
                child: Container(
                  margin: screenMargin,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: kwhite),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      QrImage(
                        //plce where the QR Image will be shown
                        data: "${globalUser.invitationCode}",
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: ksecondaryColor.withOpacity(0.3)),
                        child: DefaultTextStyle(
                            style: h2,
                            child: Text(
                              "#${globalUser.invitationCode}".toUpperCase(),
                            )),
                      ),
                    ],
                  ),
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
                  child: closeNavBar(context, "Mon ticket", kPrimaryColor))),
        ],
      ),
    );
  }
}
