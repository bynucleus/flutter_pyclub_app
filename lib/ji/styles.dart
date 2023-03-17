import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'components.dart';
import 'globals.dart';
import 'screens/jepayermaji.dart';

// ------------- COLOR---------------------
const kPrimaryColor = Color(0xFF3A0057);
const ksecondaryColor = Color(0xFFFDC600);
const kwhite = Colors.white;
const kred = Colors.redAccent;
const kTextColor = Color(0xFF50505D);
const kTextLightColor = Color(0xFF6A727D);

const MaterialColor white = MaterialColor(
  0xFFFFFFFF,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(0xFFFFFFFF),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);

var phoneNumberMask = MaskTextInputFormatter(
    mask: '+225 ## ## ## ## ##', filter: {"#": RegExp(r'[0-9]')});

// ------------- MARGIN ---------------------
const screenMargin = EdgeInsets.symmetric(vertical: 5, horizontal: 12);
const margin10 = EdgeInsets.all(10);
const circle = BorderRadius.all(Radius.circular(50));
const raduis5 = BorderRadius.all(Radius.circular(5));

const navBarStyle =
    TextStyle(fontSize: 14, color: kPrimaryColor, fontWeight: FontWeight.bold);

const rightOptionStyle =
    TextStyle(fontSize: 12, color: kPrimaryColor, fontWeight: FontWeight.bold);

// ------------- TEXT STYLES ---------------------
const screenTitle =
    TextStyle(fontSize: 21, color: Colors.black, fontWeight: FontWeight.bold);
const h1 =
    TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold);
const h1W =
    TextStyle(fontSize: 19, color: Colors.white, fontWeight: FontWeight.bold);
const h2 =
    TextStyle(fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold);
const h3 =
    TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold);
const h4 =
    TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold);

const paragraph1 = TextStyle(
  fontSize: 15,
  color: Colors.black87,
);
const paragraph2 = TextStyle(
  fontSize: 13,
  color: Colors.black87,
);

const blackLabelStyle = TextStyle(
  fontSize: 23,
  color: Colors.black,
);
const minLabelStyle = TextStyle(
  fontSize: 15,
  color: Colors.black,
);
const blackBoldLabelStyle =
    TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold);
const msgSenderStyle =
    TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.bold);

const primaryBoldLabelStyle =
    TextStyle(fontSize: 12, color: kPrimaryColor, fontWeight: FontWeight.bold);

const whiteLabelStyle = TextStyle(
  fontSize: 15,
  color: Colors.white,
);
const whiteBoldLabelStyle =
    TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold);

const warningText = TextStyle(
  fontSize: 13,
  color: Colors.red,
);

const titleW23 =
    TextStyle(fontSize: 18, color: kwhite, fontWeight: FontWeight.bold);
const profilTitle =
    TextStyle(fontSize: 21, color: kwhite, fontWeight: FontWeight.bold);
// const usernameStyle= TextStyle(fontSize: 18,color: kwhite.withOpacity(0.5),fontWeight: FontWeight.w500);
const phonenumberStyle =
    TextStyle(fontSize: 12, color: kwhite, fontWeight: FontWeight.bold);
const title21 =
    TextStyle(fontSize: 19, color: Colors.black, fontWeight: FontWeight.bold);
const title17 =
    TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600);
const deliveryStyle =
    TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold);
const title15 = TextStyle(
  fontSize: 13,
  color: Colors.black,
);

const title14b =
    TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold);

const title13W =
    TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold);

const title16W =
    TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold);
const title20W =
    TextStyle(fontSize: 19, color: Colors.white, fontWeight: FontWeight.bold);
const btnTextStyle =
    TextStyle(fontSize: 10, color: kPrimaryColor, fontWeight: FontWeight.bold);
const btnblackTextStyle =
    TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold);
const btnWhiteTextStyle =
    TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold);
const primaryButtonTextStyle =
    TextStyle(fontSize: 13, color: kwhite, fontWeight: FontWeight.bold);
const whiteButtonTextStyle =
    TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold);

const cancelBtnStyle =
    TextStyle(fontSize: 12, color: kred, fontWeight: FontWeight.bold);
const inputLabel =
    TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500);

const paragraph19 = TextStyle(
  fontSize: 19,
  color: Colors.black45,
);
const paragraph = TextStyle(
  fontSize: 18,
  color: Colors.black54,
);

const paragraphW = TextStyle(
  fontSize: 15,
  color: Colors.white,
);

Text sectionTitle(String title) {
  return Text(title, style: h1);
}

const cardTitle =
    TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.bold);
const cardSubTitle = TextStyle(fontSize: 15, color: Colors.black45);
const paragraphBlack =
    TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.bold);

const labelStyle =
    TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold);

const titleAction =
    TextStyle(fontSize: 15, color: kPrimaryColor, fontWeight: FontWeight.bold);

const bRaduis = BorderRadius.all(Radius.circular(7));

const customUnderlineInputBorder =
    UnderlineInputBorder(borderSide: BorderSide(color: Colors.black38));
const customOutlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(5)));
const customOutlineInputBorderGrey = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black45, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(5)));

// ORDER STYLES
const typeDeliveryStyle =
    TextStyle(fontSize: 15, color: Colors.black45, fontWeight: FontWeight.bold);
const orderLabelStyle =
    TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600);
const orderStatusStyle =
    TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600);
const refStyle = TextStyle(
  fontSize: 11,
  color: Colors.black45,
);
const refStyleW = TextStyle(
  fontSize: 11,
  color: Colors.white70,
);

const titleOrderStyle = TextStyle(fontSize: 10, fontWeight: FontWeight.bold);

const resumeItemStyle = TextStyle(
    fontSize: 11, color: ksecondaryColor, fontWeight: FontWeight.w500);
const resumeItemStyleW =
    TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w500);

const addressStyleW =
    TextStyle(fontSize: 15, color: Colors.white70, fontWeight: FontWeight.w400);
const orderInfoStyle =
    TextStyle(fontSize: 15, color: Colors.black45, fontWeight: FontWeight.w600);
const detailStyle =
    TextStyle(fontSize: 12, color: Colors.black45, fontWeight: FontWeight.bold);
const addressStyle =
    TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.bold);
const tariffW =
    TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold);
const tariffStyle =
    TextStyle(fontSize: 18, color: kwhite, fontWeight: FontWeight.bold);

const minTariffStyle =
    TextStyle(fontSize: 13, color: kwhite, fontWeight: FontWeight.bold);
const dateStyle =
    TextStyle(fontSize: 12, color: kPrimaryColor, fontWeight: FontWeight.bold);
const mindateStyle =
    TextStyle(fontSize: 13, color: kPrimaryColor, fontWeight: FontWeight.bold);

TextStyle feeStyle() {
  return TextStyle(
      fontSize: 8, color: kwhite.withOpacity(0.7), fontWeight: FontWeight.w500);
}

const formDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
  border:
      OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
  labelStyle: TextStyle(color: Colors.black54, fontSize: 19),
  enabledBorder: customOutlineInputBorder,
  focusedBorder: customOutlineInputBorder,
);

InputDecoration textInputSuffix(String suffix) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
    suffix: Text(
      suffix,
      style: blackBoldLabelStyle,
    ),
    border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5))),
    labelStyle: const TextStyle(color: Colors.black54, fontSize: 19),
    enabledBorder: customOutlineInputBorder,
    focusedBorder: customOutlineInputBorder,
  );
}

InputDecoration textInputDecoration(String label, String hintText) {
  return InputDecoration(
    border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
    hintText: hintText,
    labelText: label,
    labelStyle: const TextStyle(color: Colors.black54, fontSize: 19),
    enabledBorder: customOutlineInputBorderGrey,
    focusedBorder: customOutlineInputBorder,
    disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black12, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(10))),
  );
}

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  foregroundColor: Colors.black87,
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
);

AppBar detailsAppBar() {
  return AppBar(
    backgroundColor: kPrimaryColor,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: kPrimaryColor,
      ),
      onPressed: () {},
    ),
    actions: const <Widget>[
      // IconButton(
      //   icon: SvgPicture.asset("assets/icons/share.svg"),
      //   onPressed: () {},
      // ),
      // IconButton(
      //   icon: SvgPicture.asset("assets/icons/more.svg"),
      //   onPressed: () {},
      // ),
    ],
  );
}

Widget verifyAccount(BuildContext context, Text message) {
  return Container(
    padding: const EdgeInsets.all(15),
    width: gblSize.width,
    // height: gblSize.height * 0.25,
    decoration: BoxDecoration(
      color: kPrimaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: message,
          ),
          RectBtn(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
            press: (() {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const VerifyAccountScreen()),
              // );
            }),
            iconRight: const Icon(
              Icons.arrow_right_alt,
              color: kPrimaryColor,
            ),
            bgColor: kPrimaryColor.withOpacity(0.01),
            label: const Text(
              "VERIFIER MON COMPTE",
              style:
                  TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    ),
  );
}

Widget statusMsgCard(BuildContext context, String msg, Widget actionBtn) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    width: gblSize.width,
    // height: gblSize.height*0.25,
    decoration: BoxDecoration(
      color: kwhite,
      border: Border.all(color: ksecondaryColor.withOpacity(0.3)),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
            child: Text(
              msg,
              style: orderStatusStyle,
              textAlign: TextAlign.center,
            ),
          ),
          if (actionBtn != null) actionBtn
        ],
      ),
    ),
  );
}

Widget msgCard(BuildContext context, String msg, Widget actionBtn) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
    width: gblSize.width,
    // height: gblSize.height*0.25,
    decoration: BoxDecoration(
      color: kPrimaryColor.withOpacity(0.2),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Text(
              msg,
              style: title15,
              textAlign: TextAlign.center,
            ),
          ),
          if (actionBtn != null) actionBtn
        ],
      ),
    ),
  );
}

const keyboardStyle =
    TextStyle(fontSize: 19, color: Colors.black, fontWeight: FontWeight.bold);

class InputTextCard extends StatelessWidget {
  final String label;
  final TextEditingController inputController;
  final TextInputType inputType;
  final InputDecoration decoration;

  const InputTextCard(
      {Key key,
      this.label = '',
       this.inputController,
      this.inputType = TextInputType.name,
      this.decoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 5),
            child: Text(
              label,
              style: inputLabel,
            ),
          ),
          TextFormField(
              style: const TextStyle(
                  fontSize: 18.0, height: 1, color: Colors.black),
              controller: inputController,
              keyboardType: inputType,
              decoration: (decoration != null) ? decoration : formDecoration),
        ],
      ),
    );
  }
}

Widget loader([Color color]) {
  return Center(
      child: CircularProgressIndicator(
    backgroundColor: color ?? kPrimaryColor,
  ));
}

Widget loaderBtn([Color color]) {
  return Center(
      child: SizedBox(
    height: 22,
    width: 22,
    child: CircularProgressIndicator(
      strokeWidth: 2.0,
      backgroundColor: color ?? kPrimaryColor,
    ),
  ));
}

Widget emptyCard(double width, String msg) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
    width: width,
    decoration: BoxDecoration(
      color: ksecondaryColor.withOpacity(0.01),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          "assets/images/emptyBox.png",
          width: width * 0.30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
          child: Text(
            msg,
            style: title15,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

Widget shadowCard(Widget child, [double raduis]) {
  return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
          color: kwhite,
          borderRadius: BorderRadius.circular(raduis ?? 0),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 20,
              color: kPrimaryColor.withOpacity(0.22),
            ),
          ]),
      child: child);
}

Widget status(int status, String text) {
  return Row(
    children: [
      Container(
        margin: const EdgeInsets.only(right: 10),
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            color: (status == 0) ? Colors.grey : kPrimaryColor,
            borderRadius: BorderRadius.circular(50)),
      ),
      Text(
        text.toUpperCase(),
        style: refStyle,
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Widget orderInfo(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label.toUpperCase(),
          style: titleOrderStyle,
        ),
        Text(
          value.toUpperCase(),
          style: refStyle,
        )
      ],
    ),
  );
}

InputDecoration textfieldAddress(String label) {
  return InputDecoration(
    filled: true,
    hintText: label,
    fillColor: kTextLightColor.withOpacity(0.1),
    contentPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
    border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(15))),
    labelStyle: blackLabelStyle,
  );
}

void showSuccess(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black87,
      textColor: kwhite,
      fontSize: 16.0);
}

void showErrorToast(String msg) {
  Fluttertoast.showToast(
    msg: (msg != null)
        ? msg
        : "une erreur s'est produite. Si le problème persiste veuillez contacter notre service client",
    toastLength: Toast.LENGTH_SHORT,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.redAccent,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

Widget jePayeMaJI(BuildContext context) {
  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: ksecondaryColor),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: gblSize.width * 0.60,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("#Je_paie_ma_JI", style: blackBoldLabelStyle),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Retrouvez toutes les informations pour payer votre JI ici.",
                    style: paragraph,
                  ),
                )
              ]),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => JePayeMaJiPage()),
            );
          },
          child: IconBtn(
            bgColor: ksecondaryColor.withOpacity(0),
            icon: const Icon(
              Icons.arrow_forward,
              size: 30,
              color: Colors.black,
            ),
          ),
        )
      ],
    ),
  );
}
