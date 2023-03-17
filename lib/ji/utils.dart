import 'package:flutter/material.dart';

String twoLetterNumber(String number) {
  if (number.length < 2) {
    return "0$number";
  }
  return number;
}

// String noZero(double per) {
//   String le = "$per";
//   if (le.endsWith(".0")) {
//     le = le.substring(0, le.length - 2);
//   }
//   return le;
// }
String noZero(double per) {
  String le = "$per";
  if (le.contains(".") && !le.endsWith(".0")) {
    int decimalPlaces = le.split(".")[1].length;
    if (decimalPlaces > 2) {
      le = double.parse(le).toStringAsFixed(2);
    }
  }
  else if (le.endsWith(".0")) {
    le = le.substring(0, le.length - 2);
  }
  return le;
}


String threeDot(String text, int length) {
  if (text.length > length) {
    return text.substring(0, length - 3).padRight(length, ".");
  }
  return text;
}

Widget getOrderStatus(int status) {
  Color color = Colors.grey;
  IconData icon = Icons.pending;
  String text = "en attente";
  switch (status) {
    case -1:
      color = Colors.red;
      icon = Icons.dangerous;
      text = "annulé";
      break;
    case 1:
      color = Colors.green;
      icon = Icons.check_circle;
      text = "livrée";
      break;
    default:
  }
  return Container(
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
        color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
    child: Row(children: [
      Icon(
        icon,
        color: color,
        size: 13,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 3),
        child: Text(
          text,
          style: TextStyle(
              color: color, fontWeight: FontWeight.bold, fontSize: 12),
        ),
      )
    ]),
  );
}
