import 'package:flutter/material.dart';

import '../api.dart';
import '../components.dart';
import '../globals.dart';
import '../styles.dart';
import 'home.dart';

class UpdateInfo extends StatefulWidget {
  const UpdateInfo({key});

  @override
  State<UpdateInfo> createState() => _UpdateInfoState();
}

class _UpdateInfoState extends State<UpdateInfo> {
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _phoneNumberController;
  @override
  void initState() {
    super.initState();

    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneNumberController = TextEditingController();

    _firstNameController.text = globalUser.firstName ?? "";
    _lastNameController.text = globalUser.lastName ?? "";
    _phoneNumberController.text = globalUser.phoneNumber ?? "";
  }

  bool _loading = false;

  void submitForm() async {
    setState(() {
      _loading = true;
    });
    await Future.delayed(const Duration(seconds: 2), () {
      Future request = Api.updateInfo(_firstNameController.text,
          _lastNameController.text, _phoneNumberController.text);
      request.then((value) {
        if (value) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        }
        setState(() {
          _loading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backNavBar(context, "Modifier mes Info", kwhite),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              width: gblSize.width - 10,
              child: TextFormField(
                  style: const TextStyle(
                      fontSize: 15.0, height: 1, color: Colors.black),
                  controller: _lastNameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: textInputDecoration('Entrez votre nom', "Nom"))),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              width: gblSize.width - 10,
              child: TextFormField(
                  style: const TextStyle(
                      fontSize: 15.0, height: 1, color: Colors.black),
                  controller: _firstNameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      textInputDecoration('Entrez vos prénoms', "Prénoms"))),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            width: gblSize.width - 10,
            child: TextField(
                controller: _phoneNumberController,
                inputFormatters: [phoneNumberMask],
                keyboardType: TextInputType.number,
                decoration:
                    textInputDecoration('Numero de téléphone', "Téléphone")),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: RectBtn(
                hasLoader: _loading,
                label: const Text('ENREGISTRER', style: whiteBoldLabelStyle),
                bgColor: kPrimaryColor,
                press: () {
                  submitForm();
                },
              )),
        ],
      )),
    );
  }
}
