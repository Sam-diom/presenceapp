import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:presenceapp/register_screen.dart';
import 'package:presenceapp/screens/homePage.dart';
import 'package:presenceapp/screens/presenceScreen.dart';
import 'package:presenceapp/utils/onBoarding.dart';
import 'app_localizations.dart';
import 'bdHelper/mongoBdConnect.dart';
import 'login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // ...
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'), // Anglais
        Locale('fr', 'FR'), // Français
      ],
      locale: const Locale('en', 'US'), // Locale par défaut
      title: 'MyPresence',
      initialRoute: LoginPage.id,
      routes: {
        LoginPage.id: (context) => OnBoarding(),
        RegisterPage.id: (context) => const RegisterPage(title: 'inTime'),
        HomePage.id: (context) => const HomePage(userConnect: ''),
      },
    );
  }
}
