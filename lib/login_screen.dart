import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:presenceapp/app_localizations.dart';
import 'package:presenceapp/register_screen.dart';

const String registerPageTitle = 'Register UI';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  var rememberValue = false;
  Locale currentLocale =
      const Locale('fr', 'FR'); // Langue par défaut : anglais

  void _changeLanguage(Locale newLocale) {
    setState(() {
      currentLocale = newLocale;
    });
  }

  void _connection(String email, String password) async {
    try {
      if ((email != "") && (password != "")) {
        print('EMAIL : $email');
        print('MOT DE PASSE : $password');
      } else {
        print("L'ADRESSE EMAIL OU LE MOT DE PASSE NE DOIT PAS ETRE VIDE !");
      }
    } catch (error) {}
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
                    controller: _email,
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
                    controller: _password,
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
                      if (_formKey.currentState!.validate()) {
                        // Ajoutez la logique de connexion ici
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
