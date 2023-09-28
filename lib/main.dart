import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:presenceapp/login_screen.dart';
import 'app_localizations.dart';
import 'bdHelper/mongoBdConnect.dart';

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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // Anglais
        const Locale('fr', 'FR'), // Français
      ],
      locale: const Locale('en', 'US'), // Locale par défaut
      title: 'MyPresence',
      theme: ThemeData(
        // Vous pouvez ajouter votre palette de couleurs ici
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(title: 'MyPresence'),
    );
  }
}
