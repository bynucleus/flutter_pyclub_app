// import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:select_form_field/select_form_field.dart';
import 'package:flutter/material.dart';
// import 'package:myclub/model/user.dart';
import 'package:myclub/services/http_service.dart';
import 'package:myclub/ui/screen/drawer_page.dart';

import 'package:myclub/ui/widgets/button_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ndialog/ndialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key key, this.register}) : super(key: key);
  bool register;
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool checkedValue = false;

  List textfieldsStrings = [
    "", //firstName
    "", //email
    "", //password
    "", //club
    // "", //confirmPassword
    "", //niveau
    "", //code acces
  ];
  String errorMessage;
  final _firstnamekey = GlobalKey<FormState>();
  // final _lastNamekey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();
  final _club = GlobalKey<FormState>();
  // final _confirmPasswordKey = GlobalKey<FormState>();
  final _niveau = GlobalKey<FormState>();
  final _codeacceskey = GlobalKey<FormState>();
  // final _auth = FirebaseAuth.instance;

final List<Map<String, dynamic>> _items = [
  {
    'value': 'python',
    'label': 'Club Python',
    'icon': Icon(Icons.stop),
  },
  {
    'value': 'java',
    'label': 'Club Java',
    'icon': Icon(Icons.stop),

    // 'icon': Icon(Icons.fiber_manual_record),
    // 'textStyle': TextStyle(color: Colors.red),
  },
  {
    'value': 'web',
    'label': 'Club Web',
    'icon': Icon(Icons.stop),

    // 'enable': false,
    // 'icon': Icon(Icons.grade),
  },

   {
    'value': 'arduino',
    'label': 'Club IOT & Arduino',
    'icon': Icon(Icons.stop),

    // 'enable': false,
    // 'icon': Icon(Icons.grade),
  },
  
];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: Center(
        child: Container(
          height: size.height,
          width: size.height,
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xff151f2c) : Colors.white,
          ),
          child: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.02),
                        child: Align(
                          child: Text(
                            'Hello ,',
                            style: GoogleFonts.poppins(
                              color: isDarkMode
                                  ? Colors.white
                                  : const Color(0xff1D1617),
                              fontSize: size.height * 0.02,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.015),
                        child: Align(
                          child: widget.register
                              ? Text(
                                  'Creer un Compte',
                                  style: GoogleFonts.poppins(
                                    color: isDarkMode
                                        ? Colors.white
                                        : const Color(0xff1D1617),
                                    fontSize: size.height * 0.025,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Text(
                                  'Je me connecte',
                                  style: GoogleFonts.poppins(
                                    color: isDarkMode
                                        ? Colors.white
                                        : const Color(0xff1D1617),
                                    fontSize: size.height * 0.025,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * 0.01),
                      ),
                      widget.register
                          ? buildTextField(
                              "Nom & prenons",
                              Icons.person_outlined,
                              false,
                              size,
                              (valuename) {
                                if (valuename.length <= 2) {
                                  buildSnackError(
                                    'Nom invalide > 2',
                                    context,
                                    size,
                                  );
                                  return '';
                                }
                                return null;
                              },
                              _firstnamekey,
                              0,
                              isDarkMode,
                            )
                          : Container(),

                      Form(
                        child: buildTextField(
                          "Email",
                          Icons.email_outlined,
                          false,
                          size,
                          (valuemail) {
                            if (valuemail.length < 5) {
                              buildSnackError(
                                'Invalide email',
                                context,
                                size,
                              );
                              return '';
                            }
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
                                .hasMatch(valuemail)) {
                              buildSnackError(
                                'Invalide email',
                                context,
                                size,
                              );
                              return '';
                            }
                            return null;
                          },
                          _emailKey,
                          1,
                          isDarkMode,
                        ),
                      ),
                      Form(
                        child: buildTextField(
                          "Passsword",
                          Icons.lock_outline,
                          true,
                          size,
                          (valuepassword) {
                            if (valuepassword.length < 4) {
                              buildSnackError(
                                'Invalide password < 4',
                                context,
                                size,
                              );
                              return '';
                            }
                            return null;
                          },
                          _passwordKey,
                          2,
                          isDarkMode,
                        ),
                      ),
                      // Form(
                      //   child: widget.register
                      //       ? buildTextField(
                      //           "Confirmation Passsword",
                      //           Icons.lock_outline,
                      //           true,
                      //           size,
                      //           (valuepassword) {
                      //             if (valuepassword != textfieldsStrings[3]) {
                      //               buildSnackError(
                      //                 'les mots de passe ne correspondent pas',
                      //                 context,
                      //                 size,
                      //               );
                      //               return '';
                      //             }
                      //             return null;
                      //           },
                      //           _confirmPasswordKey,
                      //           3,
                      //           isDarkMode,
                      //         )
                      //       : Container(),
                      // ),

                      widget.register
                          ? buildTextField(
                              "Club",
                              Icons.grade,
                              false,
                              size,
                              (valueclub) {
                                if (valueclub.length <= 2) {
                                  buildSnackError(
                                    'Invalide club > 2',
                                    context,
                                    size,
                                  );
                                  return '';
                                }
                                return null;
                              },
                              _club,
                              3,
                              isDarkMode,
                              true,
                            )
                          : Container(),
                      Form(
                        child: widget.register
                            ? buildTextField(
                                "Niveau (ex : l1)",
                                Icons.school,
                                false,
                                size,
                                (valuescode) {
                                  return null;
                                },
                                _niveau,
                                4,
                                isDarkMode,
                              )
                            : Container(),
                      ),
                      Form(
                        child: widget.register
                            ? buildTextField(
                                "Code d'acces",
                                Icons.lock_sharp,
                                false,
                                size,
                                (valuescode) {
                                  if (![
                                    "anelda",
                                    "sminth",
                                    "pymiage",
                                    "nucleus",
                                    "myclub"
                                  ].contains(valuescode)) {
                                    buildSnackError(
                                      'Code invalide',
                                      context,
                                      size,
                                    );
                                    return '';
                                  }
                                  return null;
                                },
                                _codeacceskey,
                                5,
                                isDarkMode,
                              )
                            : Container(),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.015,
                            vertical: size.height * 0.025,
                          ),
                          child: widget.register
                              ? CheckboxListTile(
                                  title: RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              "En vous inscrivant, vous acceptez le  ",
                                          style: TextStyle(
                                            color: const Color(0xffADA4A5),
                                            fontSize: size.height * 0.015,
                                          ),
                                        ),
                                        WidgetSpan(
                                          child: InkWell(
                                            onTap: () {
                                              // ignore: avoid_print
                                              print('Conditions of Use');
                                            },
                                            child: Text(
                                              "réglément interieur",
                                              style: TextStyle(
                                                color: const Color(0xffADA4A5),
                                                decoration:
                                                    TextDecoration.underline,
                                                fontSize: size.height * 0.015,
                                              ),
                                            ),
                                          ),
                                        ),
                                        TextSpan(
                                          text: " de myclub ",
                                          style: TextStyle(
                                            color: const Color(0xffADA4A5),
                                            fontSize: size.height * 0.015,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  activeColor: const Color(0xff7B6F72),
                                  value: checkedValue,
                                  onChanged: (newValue) {
                                    setState(() {
                                      checkedValue = newValue;
                                    });
                                  },
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                )
                              : Container()
                          // InkWell(
                          //     onTap: () {
                          //       Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) =>
                          //                 const ForgotPasswordPage()),
                          //       );
                          //     },
                          //     child: Text(
                          //       "Forgot your password?",
                          //       style: TextStyle(
                          //         color: const Color(0xffADA4A5),
                          //         decoration: TextDecoration.underline,
                          //         fontSize: size.height * 0.02,
                          //       ),
                          //     ),
                          //   ),

                          ),
                      AnimatedPadding(
                        duration: const Duration(milliseconds: 500),
                        padding: widget.register
                            ? EdgeInsets.only(top: size.height * 0.025)
                            : EdgeInsets.only(top: size.height * 0.085),
                        child: ButtonWidget(
                          text: widget.register ? "inscription" : "Login",
                          backColor: isDarkMode
                              ? [
                                  Colors.black,
                                  Colors.black,
                                ]
                              : const [Color(0xff92A3FD), Color(0xff9DCEFF)],
                          textColor: const [
                            Colors.white,
                            Colors.white,
                          ],
                          onPressed: () async {
                            if (widget.register) {
                              //validation for register
                              if (_firstnamekey.currentState.validate()) {
                                if (_emailKey.currentState.validate()) {
                                  if (_passwordKey.currentState.validate()) {
                                    if (_club.currentState.validate()) {
                                      // if (_confirmPasswordKey.currentState
                                      //     .validate()) {
                                      if (checkedValue == false) {
                                        buildSnackError(
                                            'Accepte le réglément interieur',
                                            context,
                                            size);
                                      } else {
                                        register();
                                        print('Inscription');
                                      }
                                    }
                                  }
                                  // }
                                }
                              }
                            } else {
                              //validation for login
                              if (_emailKey.currentState.validate()) {
                                if (_passwordKey.currentState.validate()) {
                                  login();
                                  print('login');
                                }
                              }
                            }
                          },
                        ),
                      ),
                      AnimatedPadding(
                        duration: const Duration(milliseconds: 500),
                        padding: EdgeInsets.only(
                          top: widget.register
                              ? size.height * 0.025
                              : size.height * 0.15,
                        ),
                        child: Row(
                          //TODO: replace text logo with your logo
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'MyLogin',
                              style: GoogleFonts.poppins(
                                color: isDarkMode ? Colors.white : Colors.black,
                                fontSize: size.height * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Text(
                            //   '+',
                            //   style: GoogleFonts.poppins(
                            //     color: const Color(0xff3b22a1),
                            //     fontSize: size.height * 0.06,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: widget.register
                                  ? "Vous avez un compte? "
                                  : "Vous n'avez pas encore de compte? ",
                              style: TextStyle(
                                color: isDarkMode
                                    ? Colors.white
                                    : const Color(0xff1D1617),
                                fontSize: size.height * 0.018,
                              ),
                            ),
                            WidgetSpan(
                              child: InkWell(
                                onTap: () => setState(() {
                                  if (widget.register) {
                                    widget.register = false;
                                  } else {
                                    widget.register = true;
                                  }
                                }),
                                child: widget.register
                                    ? Text(
                                        "Login",
                                        style: TextStyle(
                                          foreground: Paint()
                                            ..shader = const LinearGradient(
                                              colors: <Color>[
                                                Color(0xffEEA4CE),
                                                Color(0xffC58BF2),
                                              ],
                                            ).createShader(
                                              const Rect.fromLTWH(
                                                0.0,
                                                0.0,
                                                200.0,
                                                70.0,
                                              ),
                                            ),
                                          fontSize: size.height * 0.018,
                                        ),
                                      )
                                    : Text(
                                        "inscription",
                                        style: TextStyle(
                                          foreground: Paint()
                                            ..shader = const LinearGradient(
                                              colors: <Color>[
                                                Color(0xffEEA4CE),
                                                Color(0xffC58BF2),
                                              ],
                                            ).createShader(
                                              const Rect.fromLTWH(
                                                  0.0, 0.0, 200.0, 70.0),
                                            ),
                                          // color: const Color(0xffC58BF2),
                                          fontSize: size.height * 0.018,
                                        ),
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
          ),
        ),
      ),
    );
  }

  bool pwVisible = false;
  Widget buildTextField(
    String hintText,
    IconData icon,
    bool password,
    size,
    FormFieldValidator validator,
    Key key,
    int stringToEdit,
    bool isDarkMode,
    [bool isselect=false]
  ) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.025),
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.05,
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.black : const Color(0xffF7F8F8),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Form(
          key: key,
          child: 
          isselect?
          SelectFormField(
  type: SelectFormFieldType.dialog, // or can be dialog
  initialValue: 'python',
  icon: Icon(Icons.format_shapes),
   
  // labelText: 'Club',
  items: _items,
  onChanged: (val) => textfieldsStrings[stringToEdit] = val,
  onSaved: (val) => print(val),
):
          TextFormField(
            style: TextStyle(
                color: isDarkMode ? const Color(0xffADA4A5) : Colors.black),
            onChanged: (value) {
              setState(() {
                textfieldsStrings[stringToEdit] = value;
                // print(textfieldsStrings[stringToEdit]);
              });
            },
            validator: validator,
            textInputAction: TextInputAction.next,
            obscureText: password ? !pwVisible : false,
            decoration: InputDecoration(
              errorStyle: const TextStyle(height: 0),
              hintStyle: const TextStyle(
                color: Color(0xffADA4A5),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(
                top: size.height * 0.012,
              ),
              hintText: hintText,
              prefixIcon: Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.005,
                ),
                child: Icon(
                  icon,
                  color: const Color(0xff7B6F72),
                ),
              ),
              suffixIcon: password
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.005,
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pwVisible = !pwVisible;
                          });
                        },
                        child: pwVisible
                            ? const Icon(
                                Icons.visibility_off_outlined,
                                color: Color(0xff7B6F72),
                              )
                            : const Icon(
                                Icons.visibility_outlined,
                                color: Color(0xff7B6F72),
                              ),
                      ),
                    )
                  : null,
            ),
          ),
      
        ),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildSnackError(
      String error, context, size) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.black,
        content: SizedBox(
          height: size.height * 0.02,
          child: Center(
            child: Text(error),
          ),
        ),
      ),
    );
  }

  register() async {
    ProgressDialog progressDialog = ProgressDialog(
      context,
      title: const Text('MyClub register'),
      message: const Text('en cours ...'),
    );
    String name = textfieldsStrings[0];
    String email = textfieldsStrings[1];
    String mp = textfieldsStrings[2];
    String club = textfieldsStrings[3];
    String niveau = textfieldsStrings[4];
    print(email);
    print(mp);
    print(club);
    if (!["anelda", "imelda", "sminth", "pymiage", "nucleus", "myclub"]
        .contains(textfieldsStrings[5])) {
      buildSnackError(
        'Code invalide',
        context,
        MediaQuery.of(context).size,
      );
      return;
    }
    progressDialog.show();

    var data = {
      'name': name,
      'pcc': "50",
      'niveau': niveau,
      'email': email,
      'password': mp,
      'club': club,
      'profileImage': "images/avator1.svg",
    };
    var res = await HttpService.authData(data, 'users');
    print(res.toString());
    if (res == false) {
      Fluttertoast.showToast(msg: "une erreur est survenu, merci de ressayer");
    } else {
      var body = json.decode(res.body);
      print(body.toString());

      if (body['success']) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', json.encode(body['token']));
        localStorage.setString('user', json.encode(body['user']));
        localStorage.setString('email', json.encode(body['user']['email']));
        localStorage.setString('club', json.encode(body['user']['club']));
        localStorage.setString('pcc', json.encode(body['user']['pcc']));
        progressDialog.dismiss();

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => DrawerPage()));
      } else {
        Fluttertoast.showToast(msg: body['message']);
      }
    }
    /*try {
      // FirebaseAuth auth = FirebaseAuth.instance;

      // UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: textfieldsStrings[2], password: textfieldsStrings[3]);

      if (userCredential.user != null) {
        API_Manager().createUser(name, club, email, niveau, mp);

        progressDialog.dismiss();

        Fluttertoast.showToast(msg: 'Vous vous êtes bien enregisté !');

        Navigator.of(context).pushNamed('/home');
      } else {
        Fluttertoast.showToast(msg: 'erreur, veuillez ressayer !');
      }

      progressDialog.dismiss();
    } on FirebaseAuthException catch (e) {
      progressDialog.dismiss();
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'l\'email est dejà utiliser');
      } else if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'mauvais password');
      }
    } catch (e) {
      // progressDialog.dismiss();
      Fluttertoast.showToast(msg: 'une erreur est survenue');
    }*/
  }

  Future<void> login() async {
    ProgressDialog progressDialog = ProgressDialog(
      context,
      title: const Text('MyClub login'),
      message: const Text('en cours ...'),
    );

    progressDialog.show();

    String email = textfieldsStrings[1];
    String mp = textfieldsStrings[2];
    if (email.isNotEmpty) {
      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(email)) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Entrez un email valide")));
      } else {
        if (mp.isNotEmpty) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (!regex.hasMatch(mp)) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Entrez un mot de passe valide(Min. 6 )")));
          } else {
            try {
              var data = {
                'email': email,
                'password': mp,
              };
              var res = await HttpService.authData(data, 'login');
              // print(res.toString());
              if (res == false) {
                Fluttertoast.showToast(
                    msg: "une erreur est survenu, merci de ressayer");
              } else {
                var body = json.decode(res.body);
                print(body.toString());

                if (body['success']) {
                  SharedPreferences localStorage =
                      await SharedPreferences.getInstance();
                  localStorage.setString('token', json.encode(body['token']));
                  localStorage.setString('user', json.encode(body['user']));
                  localStorage.setString(
                      'email', json.encode(body['user']['email']));
                  localStorage.setString('club', json.encode(body['user']['club']));
        localStorage.setString('pcc', json.encode(body['user']['pcc']));

                  progressDialog.dismiss();

                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => DrawerPage()));
                } else {
                  Fluttertoast.showToast(msg: body['message']);
                }
              }
              // _auth
              //     .signInWithEmailAndPassword(email: email, password: mp)
              //     .then((uid) => {
              //           // print("----------------"),
              //           // print(uid.user),
              //           // API_Manager().createUser(name, club, email, mp),
              //           progressDialog.dismiss(),
              //           Fluttertoast.showToast(msg: "vous êtes bien connecté"),
              //           Navigator.of(context).pushReplacement(MaterialPageRoute(
              //               builder: (context) => DrawerPage())),
              //         });
            } catch (error) {
              // switch (error.code) {
              //   case "invalid-email":
              //     errorMessage = "email invalide.";

              //     break;
              //   case "wrong-password":
              //     errorMessage = "mauvais mot de passe.";
              //     break;
              //   case "user-not-found":
              //     errorMessage = "un membre avec ce mail n'existe pas.";
              //     break;
              //   case "user-disabled":
              //     errorMessage = "le membre avec cette email à été bloqué.";
              //     break;
              //   case "too-many-requests":
              //     errorMessage = "Trop de requete, ressayer";
              //     break;
              //   case "operation-not-allowed":
              //     errorMessage = "le login n'est pas activé.";
              //     break;
              //   default:
              //     errorMessage =
              //         "une erreur inconnue est survenue, ressayez !.";
              // }
              Fluttertoast.showToast(
                  msg: "une erreur est survenue, veuillez ressayer");
              print(error.toString());
            }
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (context) => HomePage()));
            // // var response = await http.get(Uri.parse(baseUrl+"/api/auth/login"));
            // if(response.statusCode==200){
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            // } else {
            //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid Credentials")));
            // }
          }
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Entrez votre Password")));
        }
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Entrez votre email")));
    }
    progressDialog.dismiss();
  }
}
