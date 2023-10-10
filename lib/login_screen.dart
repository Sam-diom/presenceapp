import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:presenceapp/app_localizations.dart';
import 'package:presenceapp/register_screen.dart';
import 'package:presenceapp/homePage.dart'; // Importez votre page d'accueil
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:presenceapp/mongodbModel.dart';

const String registerPageTitle = 'Register UI';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
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

  Future<bool> authenticateUser(String email, String password) async {
    // Effectuez une recherche dans la base de données pour trouver l'utilisateur par e-mail
    final user = await getUserByEmail(email);

    if (user != null && user.password == password) {
      return true; // Authentification réussie
    } else {
      return false; // Authentification échouée
    }
  }

  // Simulez une fonction pour obtenir un utilisateur par e-mail depuis votre base de données
  Future<MongoModel?> getUserByEmail(String email) async {
    try {
      final db = mongo.Db(
          "mongodb://samdiom001:yJWnchQPIDJeWK7y@cluster0.vdz4m2r.mongodb.net");

      await db.open();

      final userCollection = db.collection('users');

      final userDocument =
          await userCollection.findOne(mongo.where.eq('email', email));

      if (userDocument != null) {
        final user = MongoModel.fromMap(userDocument);
        return user;
      }

      return null; // Aucun utilisateur trouvé avec cet e-mail
    } catch (e) {
      print('Erreur lors de la recherche de l\'utilisateur par e-mail : $e');
      return null;
    }
  }

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
                    controller: _emailController,
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
                    controller: _passwordController,
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final email = _emailController.text;
                        final password = _passwordController.text;

                        if (await authenticateUser(email, password)) {
                          // Authentification réussie, rediriger vers la page d'accueil
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HomePage(), // Remplacez par votre page d'accueil
                            ),
                          );
                        } else {
                          // Afficher un message d'erreur si l'authentification échoue
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Identifiants incorrects"),
                            ),
                          );
                        }
                      }
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
