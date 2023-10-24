import 'package:introduction_slider/introduction_slider.dart';
import 'package:flutter/material.dart';
import 'package:inTime/login_screen.dart';

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IntroductionSlider(
        showStatusBar: true,
        items: [
          IntroductionSliderItem(
            logo: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                "assets/img1.png",
                height: 350,
                width: 350,
              ),
            ),
            title: Padding(
              padding: EdgeInsets.only(
                bottom: 20,
              ),
              child: Text(
                "Bienvenue Sur inTime",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            subtitle: const Padding(
              padding: EdgeInsets.only(
                bottom: 170,
                left: 20,
                right: 20,
              ),
              child: Text(
                "L'Application de Gestion de Présence proposant un ensemble de fonctionnalités clés pour répondre à vos besoins de gestion de présence !",
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          IntroductionSliderItem(
            logo: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                "assets/img2.png",
                height: 350,
                width: 350,
              ),
            ),
            title: const Padding(
              padding: EdgeInsets.only(
                bottom: 20,
              ),
              child: Text(
                "inTime et la gestion de présence !",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            subtitle: const Padding(
              padding: EdgeInsets.only(
                bottom: 170,
                left: 20,
                right: 20,
              ),
              child: Text(
                "Enregistrer vos présences en toute simplicité, que ce soit lors de cours, de réunions, d'événements ou d'autres activités. Chaque présence est horodatée, assurant ainsi une traçabilité précise des entrées et sorties.",
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          IntroductionSliderItem(
            logo: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                "assets/img3.png",
                height: 350,
                width: 350,
              ),
            ),
            title: const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                textAlign: TextAlign.center,
                "avec inTime !",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(
                bottom: 170,
                left: 20,
                right: 20,
              ),
              child: Text(
                "Accédez à des rapports détaillés et à des statistiques sur la présence. Recevez des notifications et des alertes en temps réel pour les absences, les retards ou d'autres événements importants.",
                style: TextStyle(
                  fontSize: 20,
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
