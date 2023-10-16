import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:presenceapp/app_localizations.dart';
import 'package:presenceapp/register_screen.dart';
import 'package:presenceapp/screens/homePage.dart';

import 'bdHelper/mongoBdConnect.dart';
import 'utils/afficher_les_donnees.dart';
import 'package:introduction_slider/introduction_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';

const String registerPageTitle = 'Register UI';
final _formKey = GlobalKey<FormState>();

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IntroductionSlider(
        showStatusBar: true,
        items: [
          IntroductionSliderItem(
            logo: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset("assets/img1.png"),
            ),
            title: Padding(
              padding: EdgeInsets.only(
                bottom: 30,
              ),
              child: Text(
                "Bienvenue Sur inTime",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            subtitle: const Padding(
              padding: EdgeInsets.only(
                bottom: 100,
                left: 20,
                right: 20,
              ),
              child: Text(
                "L'Application de Gestion de Présence proposant un ensemble de fonctionnalités clés pour répondre à vos besoins de gestion de présence !",
                style: TextStyle(
                  fontSize: 23,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          IntroductionSliderItem(
            logo: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset("assets/img2.png"),
            ),
            title: const Padding(
              padding: EdgeInsets.only(
                bottom: 30,
              ),
              child: Text(
                "inTime et la gestion de présence !",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            subtitle: const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "Enregistrer vos présences en toute simplicité, que ce soit lors de cours, de réunions, d'événements ou d'autres activités. Chaque présence est horodatée, assurant ainsi une traçabilité précise des entrées et sorties.",
                style: TextStyle(
                  fontSize: 23,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          IntroductionSliderItem(
            logo: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset("assets/img3.png"),
            ),
            title: const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                textAlign: TextAlign.center,
                "avec inTime !",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            subtitle: Padding(
              padding: EdgeInsets.all(
                25,
              ),
              child: Text(
                "Accédez à des rapports détaillés et à des statistiques sur la présence. Recevez des notifications et des alertes en temps réel pour les absences, les retards ou d'autres événements importants.",
                style: TextStyle(
                  fontSize: 23,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
        done: Done(
          child: ElevatedButton(
            child: Text(
              'Commencer !',
              style: TextStyle(
                fontSize: 20,
                color: Colors.deepOrange,
              ),
            ),
            onPressed: null,
          ),
          home: LoginPage(title: 'inTime'),
        ),
        next: Next(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 30,
            ),
            child: Text("Suivant",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
        back: Back(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "Retour",
              style: TextStyle(
                fontSize: 17,
                color: Colors.deepOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        dotIndicator: DotIndicator(
          selectedColor: Colors.orange,
          unselectedColor: Colors.blueAccent,
          size: 10,
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  static const String id = 'login';
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String userConnect = "";
  late TextEditingController controllerEmail;
  late TextEditingController controllerPassword;
  var rememberValue = false;
  Locale currentLocale =
      const Locale('fr', 'FR'); // Langue par défaut : anglais

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _changeLanguage(Locale newLocale) {
    setState(() {
      currentLocale = newLocale;
    });
  }

  void verif(
      {required TextEditingController controllerEmail1,
      required TextEditingController controllerPassword1}) async {
    final formSate = _formKey.currentState;
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    if (_formKey.currentState!.validate()) {
      await for (var snapshots in MongoDatabase.userCollection.find()) {
        if ((snapshots["email"] == controllerEmail1.text) &&
            (snapshots["password"] == controllerPassword1.text)) {
          Navigator.pop(context);

          MaterialPageRoute route =
              MaterialPageRoute(builder: (context) => HomePage());
          Navigator.pushReplacement(context, route);
          print(snapshots["email"]);
          print(snapshots["password"]);

          setState(() {
            controllerEmail.text = "";
            controllerPassword.text = "";
            userConnect = snapshots["lastName"];
          });
        } else if ((snapshots["email"] != controllerEmail1.text) &&
            (snapshots["password"] == controllerPassword1.text)) {
          print("Une erreur est survenu");
          Navigator.pop(context);

          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text("Email incorrect, veillez réessayer"),
              );
            },
          );
        } else if ((snapshots["password"] != controllerPassword1.text) &&
            (snapshots["email"] == controllerEmail1.text)) {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text("Password incorrect, veillez réessayer"),
              );
            },
          );
        } else {
          print("Une erreur est survenu veillez réessayer");
          Navigator.pop(context);

          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text("Identifiant incorrect, veillez réessayer"),
              );
            },
          );
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //verif();
    controllerEmail = TextEditingController();
    controllerPassword = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              appLocalizations
                  .translate('signInTitle'), // Utilisation de la traduction
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
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
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                    ),
                    child: Text(
                      appLocalizations.translate('signInButton'),
                      style: const TextStyle(
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
