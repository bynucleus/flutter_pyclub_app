import 'package:flutter/material.dart';

import '../api.dart';
import '../components.dart';
import '../globals.dart';
import '../styles.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
   TextEditingController _emailController;
   TextEditingController _passwordController;
  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  bool _loading = false;

  void submitForm() async {
    setState(() {
      _loading = true;
    });
    await Future.delayed(const Duration(seconds: 2), () {
      Future request =
          Api.login(_emailController.text, _passwordController.text);
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
      appBar: closeNavBar(context, "", kPrimaryColor),
      backgroundColor: Colors.white,
      body: Container(
          color: kPrimaryColor.withOpacity(0.2),
          height: gblSize.height,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(
                      color: kwhite, borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Bienvenue",
                        style: h2,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Veuillez entrer vos informations",
                        textAlign: TextAlign.left,
                        style: paragraph,
                      ),
                      const SizedBox(
                        height: 21,
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          width: gblSize.width - 10,
                          child: TextFormField(
                              style: const TextStyle(
                                  fontSize: 15.0,
                                  height: 1,
                                  color: Colors.black),
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: textInputDecoration(
                                  'Entrer votre Email..', "Email"))),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          width: gblSize.width - 10,
                          child: TextFormField(
                              style: const TextStyle(
                                  fontSize: 15.0,
                                  height: 1,
                                  color: Colors.black),
                              controller: _passwordController,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: textInputDecoration('Mot de passe',
                                  'Entrer votre Mot de passe..'))),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 5),
                          child: RectBtn(
                            label: const Text('CONNEXION',
                                style: whiteBoldLabelStyle),
                            bgColor: kPrimaryColor,
                            hasLoader: _loading,
                            press: () {
                              submitForm();
                            },
                          )),
                      Padding(
                        padding: screenMargin,
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Text(
                                'pas de compte? inscrivez-vous sur:',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Text(
                                ' www.miage-ufhb.ci',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
