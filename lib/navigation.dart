import 'package:flutter/material.dart';
import 'package:inTime/login_screen.dart';
import 'package:inTime/screens/homePage.dart';
import 'package:inTime/utils/onBoarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationPage extends StatefulWidget {
  static const String id = "navigationPage";

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  bool? onboarded = false;
  bool? connected = false;
  bool loading = false;

  _localStorageSetting() async {
    setState(() {
      loading = true;
    });
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool('onboarded') == null) {
      pref.setBool('onboarded', false);
    } else {
      setState(() {
        onboarded = pref.getBool('onboarded');
      });
    }

    if (pref.getBool('connected') == null) {
      pref.setBool('connected', false);
    } else {
      setState(() {
        connected = pref.getBool('connected');
      });
    }

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _localStorageSetting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 5.0,
              ),
            )
          : connected!
              ? const HomePage(
                  userConnect: '',
                )
              : onboarded!
                  ? const LoginPage(title: "inTime")
                  : OnBoarding(),
    );
  }
}