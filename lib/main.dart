import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations.dart';
import 'bdHelper/mongoBdConnect.dart';
import 'login_screen.dart';
import 'navigation.dart';
import 'register_screen.dart';
import 'screens/bottomNavBar.dart';
import 'screens/homePage.dart';

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
        HomePage.id: (context) => const HomePage(userConnect: ''),
        BottomNavBar.id: (context) => const BottomNavBar(),
      },
    );
  }
}
