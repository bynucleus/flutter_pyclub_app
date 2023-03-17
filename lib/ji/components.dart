import 'package:flutter/material.dart';
import 'api.dart';
import 'models/others.dart';
import 'screens/account.dart';
import 'screens/restauration.dart';
import 'dart:async';
import 'globals.dart';
import 'models/order.dart';
import 'screens/panel.dart';
import 'styles.dart';
import 'utils.dart';

AppBar navBar(BuildContext context, String title) {
  return AppBar(
    automaticallyImplyLeading: false,
    iconTheme: const IconThemeData(color: kPrimaryColor),
    backgroundColor: kwhite.withOpacity(0),
    elevation: 0,
    title: Padding(
      padding: const EdgeInsets.symmetric(vertical: 80),
      child: Container(
          width: gblSize.width * 0.6,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kPrimaryColor.withOpacity(0.1)),
          child: Text(title, style: navBarStyle, textAlign: TextAlign.center)),
    ),
    actions: [
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Account()),
          );
        },
        child: Center(
          child: Container(
              width: 45,
              height: 45,
              padding: const EdgeInsets.all(1),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kPrimaryColor.withOpacity(0.2)),
              child: (globalUser != null)
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(500),
                      child: (globalUser.photo == null)
                          ? Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                'assets/images/user.png',
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.network(
                              '$ipAddress${globalUser.photo}',
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace stackTrace) {
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(
                                    'assets/images/user.png',
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(500),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          'assets/images/user.png',
                          fit: BoxFit.cover,
                        ),
                      ))),
        ),
      ),
    ],
  );
}

AppBar backNavBar(BuildContext context, String title, Color color,
    [Function() back]) {
  return AppBar(
    iconTheme: const IconThemeData(color: kPrimaryColor),
    leading: Builder(
      builder: (context) => Padding(
        padding: const EdgeInsets.all(7.0),
        child: InkWell(
          onTap: (back != null)
              ? back
              : () {
                  Navigator.pop(context);
                },
          child: Container(
              padding: const EdgeInsets.all(8),
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: kwhite.withOpacity(0)),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
      ),
    ),
    elevation: 0,
    centerTitle: true,
    title: Container(
        width: gblSize.width * 0.6,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kPrimaryColor.withOpacity(0.1)),
        child:
            Text(title ?? '', style: navBarStyle, textAlign: TextAlign.center)),
  );
}

AppBar closeNavBar(BuildContext context, String title, Color color) {
  return AppBar(
    iconTheme: const IconThemeData(color: kPrimaryColor),
    leading: const SizedBox(),
    actions: [
      Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.all(7.0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                padding: const EdgeInsets.all(8),
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: kwhite.withOpacity(0)),
                child: const Icon(
                  Icons.close,
                  color: Colors.black,
                )),
          ),
        ),
      )
    ],
    backgroundColor: kPrimaryColor.withOpacity(0.2),
    elevation: 0,
    centerTitle: true,
    title:
        Text(title ?? '', style: blackLabelStyle, textAlign: TextAlign.center),
  );
}

class IconBtn extends StatelessWidget {
  const IconBtn({
    Key key,
    this.press,
    this.icon,
    this.bgColor,
    this.textColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
    this.radius = true,
  }) : super(key: key);

  final Icon icon;
  final bool radius;
  final Color bgColor;
  final Color textColor;
  final EdgeInsets padding;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.rectangle,
          borderRadius:
              (radius) ? circle : const BorderRadius.all(Radius.circular(10))),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: press,
          child: Padding(padding: padding, child: icon),
        ),
      ),
    );
  }
}

class RectBtn extends StatelessWidget {
  const RectBtn({
    Key key,
    this.press,
    this.iconRight,
    this.iconLeft,
    this.bgColor = kwhite,
    this.label,
    this.bordered,
    this.hasLoader = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
  }) : super(key: key);

  final Border bordered;
  final Icon iconRight;
  final Icon iconLeft;
  final Color bgColor;
  final Text label;
  final EdgeInsets padding;
  final bool hasLoader;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 50),
      decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.rectangle,
          border: bordered ?? Border.all(color: bgColor),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (hasLoader)
              ? () {
                  // ignore: avoid_print
                  print("Nothing");
                }
              : press,
          child: (hasLoader)
              ? loaderBtn(kwhite)
              : Padding(
                  padding: padding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (iconLeft != null) iconLeft,
                      Container(
                        padding: const EdgeInsets.only(right: 8, left: 8),
                        child: label,
                      ),
                      if (iconRight != null) iconRight
                    ],
                  )),
        ),
      ),
    );
  }
}

class OutlineBtn extends StatelessWidget {
  const OutlineBtn({
    Key key,
    this.press,
    this.iconRight,
    this.iconLeft,
    this.bgColor = kwhite,
    this.label,
    this.textColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
  }) : super(key: key);

  final Icon iconRight;
  final Icon iconLeft;
  final Color bgColor;
  final Color textColor;
  final Text label;
  final EdgeInsets padding;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.rectangle,
          border: Border.all(color: textColor, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: press,
          child: Padding(
              padding: padding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (iconLeft != null) iconLeft,
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: label,
                  ),
                  if (iconRight != null) iconRight
                ],
              )),
        ),
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  const OptionCard({
    Key key,
    this.label = '',
    this.tap = defaultFunc,
    this.image = 'assets/images/user.png',
  }) : super(key: key);

  final String image;
  final String label;
  final Function() tap;

  static void defaultFunc() {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: const BoxDecoration(
                            color: kwhite, borderRadius: circle),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(image)),
                      ),
                    ),
                    Text(label,
                        style: const TextStyle(
                            fontSize: 17,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
                const Icon(Icons.navigate_next_rounded)
              ]),
        ),
      ),
    );
  }
}

Widget activityCard(BuildContext context, Activity activity, Widget widget) {
  const activityDescription = TextStyle(
      fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500);
  return 
  
  Stack(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Container(
          padding: const EdgeInsets.only(left: 25, bottom: 12),
          decoration: const BoxDecoration(
              border: Border(left: BorderSide(color: Colors.black))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${activity.title}".toUpperCase(),
                        style: orderStatusStyle,
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        '${activity.time}',
                        style: mindateStyle,
                        textAlign: TextAlign.left,
                      ),
                    ]),
              ),
              if (activity.description != "")
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  decoration: BoxDecoration(
                      color: ksecondaryColor.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "${activity.description}",
                    style: activityDescription,
                    textAlign: TextAlign.center,
                  ),
                ),
              if (activity.canInteract ?? false)
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  width: gblSize.width * 0.4,
                  child: RectBtn(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    bgColor: kwhite.withOpacity(0.15),
                    bordered: Border.all(color: Colors.black, width: 1),
                    iconRight: const Icon(
                      Icons.arrow_forward_outlined,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "ACCEDER ",
                      style: whiteButtonTextStyle,
                    ),
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                (activity.room == "RESTAURATION")
                                    ? const Restauration()
                                    : Panel(room: activity.room)),
                      );
                    },
                  ),
                ),
              widget
            ],
          ),
        ),
      ),
      Positioned(
        top: 0,
        left: 0,
        child: Container(
          decoration:
              const BoxDecoration(borderRadius: circle, color: kPrimaryColor),
          height: 40,
          width: 40,
        ),
      ),
    ],
  );
}

Widget menuItem(String image, String label, bool left, Function() tap) {
  const labelStyle = TextStyle(
    fontSize: 15,
    color: Colors.black,
  );
  return InkWell(
    onTap: tap,
    child: shadowCard(
        Container(
          padding: const EdgeInsets.all(8.0),
          height: (gblSize.width * 0.4) * 1.4,
          width: (gblSize.width * 0.4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                image,
                height: (((gblSize.width * 0.4) - 10) * 1.4) - 60,
                width: (gblSize.width * 0.4) - 10,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                label.toUpperCase(),
                style: labelStyle,
              )
            ],
          ),
        ),
        15),
  );
}

class DateCountdown extends StatefulWidget {
  final DateTime targetDate;

  const DateCountdown({key,  this.targetDate});

  @override
  _DateCountdownState createState() => _DateCountdownState();
}

class _DateCountdownState extends State<DateCountdown> {
   Timer _timer;
  int _days = 0;
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        final now = DateTime.now();
        final duration = widget.targetDate.difference(now);
        _days = duration.inDays;
        _hours = duration.inHours.remainder(24);
        _minutes = duration.inMinutes.remainder(60);
        _seconds = duration.inSeconds.remainder(60);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        counterBox(_days, "jours"),
        counterBox(_hours, "heures"),
        counterBox(_minutes, "minutes"),
        counterBox(_seconds, "secondes")
      ],
    );
  }
}

Widget counterBox(int number, String label) {
  const numberStyle = TextStyle(
      fontSize: 42, fontWeight: FontWeight.bold, color: kPrimaryColor);
  const labelStyle =
      TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black);
  return Container(
    padding: const EdgeInsets.all(7),
    width: gblSize.width * 0.25 - 10,
    height: gblSize.width * 0.25 - 10,
    decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(50),
        color: ksecondaryColor.withOpacity(0.0)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$number".padLeft(2, "0"),
          style: numberStyle,
        ),
        Text(
          label,
          style: labelStyle,
        )
      ],
    ),
  );
}

class CustomModal extends StatelessWidget {
  const CustomModal({
    key,
    this.title = "",
    this.message = "",
    this.success = false,
    this.action,
  });

  final String title;
  final Function() action;
  final String message;
  final bool success;

  @override
  Widget build(BuildContext context) {
    IconData ic = (success) ? Icons.check : Icons.error;
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Container(
          height: gblSize.height * 0.50,
          width: gblSize.width * 0.92,
          decoration: BoxDecoration(
            color: (success) ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 20,
                child: Container(
                  decoration: const BoxDecoration(
                      // color: kwhite,
                      borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          ic,
                          size: 65,
                          color: kwhite,
                        ),
                        const SizedBox(height: 10),
                        DefaultTextStyle(
                            style: h1W,
                            child: Text(
                              title,
                              textAlign: TextAlign.center,
                            )),
                        DefaultTextStyle(
                            style: paragraphW,
                            child: Text(
                              message,
                              textAlign: TextAlign.center,
                            )),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    child: Icon(
                      Icons.close,
                      size: 30,
                      color: kwhite.withOpacity(0.7),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  )),
              Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    // width: gblSize.width * 0.8,
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: screenMargin,
                    child: RectBtn(
                      bordered: Border.all(color: kwhite),
                      label: const Text('FERMER', style: whiteBoldLabelStyle),
                      bgColor: kwhite.withOpacity(0),
                      press: action ??
                          () {
                            Navigator.of(context).pop();
                          },
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

Widget orderList(
  List<Order> allOrder,
  Widget empty,
) {
  return Container(
    margin: screenMargin,
    height: 300,
    child: (allOrder.isEmpty)
        ? empty
        : ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: allOrder.length,
            itemBuilder: (context, index) {
              return orderCard(allOrder[index]);
            }),
  );
}

Widget orderCard(Order order) {
  List<Widget> foodImageList = [];
  String foodList = "";

  double left = 0;
  for (var food in order.foods) {
    foodImageList.add(
      Positioned(
        top: 0,
        left: left,
        child: Container(
          width: 35,
          height: 35,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(500),
            child: Image.network(
              '$ipAddress${food.image}',
              width: 35,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
    foodList = "$foodList ${food.name} -";
    left = left + 25;
  }
  foodList = foodList.substring(1, foodList.length - 1);
  const refStyle = TextStyle(
      fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500);
  return Column(
    children: [
      Container(
        // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        decoration: BoxDecoration(color: Colors.black45.withOpacity(0.02)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              threeDot("#CMD ${order.id}", 25).toUpperCase(),
              style: refStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 95,
                    height: 40,
                    child: Stack(
                      children: foodImageList,
                    ),
                  ),
                  SizedBox(
                    width: gblSize.width - 150,
                    child: Text(
                      foodList.toUpperCase(),
                      style: minLabelStyle,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                getOrderStatus(order.status),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              height: 2,
            )
          ],
        ),
      ),
    ],
  );
}
