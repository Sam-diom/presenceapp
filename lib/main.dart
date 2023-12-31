import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:inTime/navigation.dart';
import 'package:inTime/register_screen.dart';
import 'package:inTime/screens/bottomNavBar.dart';
import 'package:inTime/screens/homePage.dart';

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
      theme: ThemeData(appBarTheme: const AppBarTheme(color: Colors.white)),
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
      initialRoute: NavigationPage.id,
      routes: {
        NavigationPage.id: (context) => NavigationPage(),
        LoginPage.id: (context) => const LoginPage(title: 'inTime'),
        RegisterPage.id: (context) => const RegisterPage(title: 'inTime'),
        BottomNavBar.id: (context) => const BottomNavBar(),
        HomePage.id: (context) => const HomePage(),
      },
    );
  }
}
