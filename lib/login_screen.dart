import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inTime/app_localizations.dart';
import 'package:inTime/register_screen.dart';
import 'package:inTime/screens/bottomNavBar.dart';
// import 'package:inTime/screens/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bdHelper/mongoBdConnect.dart';

const String registerPageTitle = 'Register UI';
final _formKey = GlobalKey<FormState>();
String userConnect = "";

class LoginPage extends StatefulWidget {
  static const String id = 'login';

  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String emailConnect = "";
  String passwordConnect = '';
  late TextEditingController controllerEmail;
  late TextEditingController controllerPassword;
  var rememberValue = false;
  Locale currentLocale =
      const Locale('fr', 'FR'); // Langue par défaut : anglais

  void _changeLanguage(Locale newLocale) {
    setState(() {
      currentLocale = newLocale;
    });
  }

  _connected() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('connected', true);
  }

  void verif(
      {required TextEditingController controllerEmail1,
      required TextEditingController controllerPassword1}) async {
    if (_formKey.currentState!.validate()) {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      await for (var snapshots in MongoDatabase.userCollection.find()) {
        if ((snapshots["email"] == controllerEmail1.text.trim()) &&
            (snapshots["password"] == controllerPassword1.text.trim())) {
          setState(() {
            emailConnect = snapshots["email"];
            passwordConnect = snapshots["password"];

            userConnect = snapshots["lastName"] + " " + snapshots["firstName"];
          });
        } else if (snapshots["email"] == controllerEmail1.text &&
            snapshots["password"] != controllerPassword1.text) {
          setState(() {
            emailConnect = snapshots["email"];
          });
        } else if (snapshots["email"] != controllerEmail1.text.trim() &&
            snapshots["password"] == controllerPassword1.text.trim()) {
          setState(() {
            passwordConnect = snapshots["password"];
          });
        } else {
          emailConnect = emailConnect;
          passwordConnect = passwordConnect;
        }
      }
      print(emailConnect);
      print(passwordConnect);
      if (emailConnect == controllerEmail1.text.trim() &&
          passwordConnect == controllerPassword1.text.trim()) {
        Navigator.pop(context);
        MaterialPageRoute newRoute =
            MaterialPageRoute(builder: ((context) => BottomNavBar()));
        Navigator.pushReplacement(context, newRoute);
        setState(() {
          controllerEmail.text = "";
          controllerPassword.text = "";
        });
      } else if ((emailConnect == controllerEmail1.text.trim() &&
              passwordConnect != controllerPassword1.text.trim()) ||
          (emailConnect != controllerEmail1.text.trim() &&
              passwordConnect == controllerPassword1.text.trim())) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text(
                  "Adresse email ou mot de passe incorrecte, veillez réessayer svp!"),
            );
          },
        );
      } else {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("Identifiant inexistant, veillez réessayer svp"),
            );
          },
        );
      }
    }
  }

  /*  */

  @override
  void initState() {
    super.initState();
    //verif();
    controllerEmail = TextEditingController();
    controllerPassword = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    controllerEmail.dispose();
    controllerPassword.dispose();
  }

  /* 
  import 'package:mongo_dart/mongo_dart.dart';

void main() async {
  final db = await Db.create('mongodb://localhost:27017/mydb');
  await db.open();
  final collection = db.collection('mycollection');
  await for (var doc in collection.find()) {
    // Votre code ici
  }
  await db.close();
}

   */

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations(currentLocale);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 241, 241),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              appLocalizations.translate('signInTitle'),
              style: GoogleFonts.acme(
                  textStyle: const TextStyle(color: Colors.teal, fontSize: 40)),
            ),
            const SizedBox(
              height: 60,
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controllerEmail,
                    validator: (value) => EmailValidator.validate(value!)
                        ? null
                        : appLocalizations.translate('validEmailMessage'),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: appLocalizations.translate('enterEmailHint'),
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controllerPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return appLocalizations.translate('enterPasswordHint');
                      }
                      return null;
                    },
                    maxLines: 1,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: appLocalizations.translate('enterPasswordHint'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Ajoutez la logique de connexion ici

                      verif(
                          controllerEmail1: controllerEmail,
                          controllerPassword1: controllerPassword);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                    ),
                    child: Text(
                      appLocalizations.translate('signInButton'),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(appLocalizations.translate('notRegisteredYet')),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(
                                title: registerPageTitle,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          appLocalizations.translate('createAccount'),
                          style: const TextStyle(
                            color: Colors.teal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
