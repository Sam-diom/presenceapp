import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:presenceapp/app_localizations.dart';
import 'package:presenceapp/register_screen.dart';

import 'bdHelper/mongoBdConnect.dart';
import 'utils/afficher_les_donnees.dart';

const String registerPageTitle = 'Register UI';
final _formKey = GlobalKey<FormState>();

class LoginPage extends StatefulWidget {
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

          MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => MongoDbDisplay(
                    userConnect: userConnect,
                  ));
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
                  CheckboxListTile(
                    title: Text(appLocalizations.translate('rememberMe') ?? ''),
                    contentPadding: EdgeInsets.zero,
                    value: rememberValue,
                    activeColor: Theme.of(context).colorScheme.primary,
                    onChanged: (newValue) {
                      setState(() {
                        rememberValue = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  const SizedBox(
                    height: 20,
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
                        child:
                            Text(appLocalizations.translate('createAccount')),
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
