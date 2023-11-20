// ignore_for_file: use_super_parameters, camel_case_types

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inTime/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

/// Widget de la page d'accueil qui affiche l'écran d'accueil de l'application.
class HomePage extends StatefulWidget {
  static const String id = 'home';
  const HomePage({super.key, required this.userConnect});
  final String userConnect;

  /// L'état est géré par _HomePageState.
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _selectedImage;
  DateTime today = DateTime.now();

  bool loading = false;

  @override
  void dispose() {
    super.dispose();
  }

  void _onDaySelected(DateTime Selectedday, DateTime focusDay) {
    setState(() {
      today = Selectedday;
    });
  }

  List<String> mois = [
    'Janvier',
    'Février',
    'Mars',
    'Avril',
    'Mai',
    'Juin',
    'Juillet',
    'Août',
    'Septembre',
    'Octobre',
    'Novembre',
    'Décembre',
  ];

  List<String> days = [
    'Lundi',
    'Mardi',
    'Mercredi',
    'Jeudi',
    'Vendredi',
    'Samedi'
  ];

  /// TableCalendar pour sélectionner des dates, des boutons de sélection de mois
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> drawerList = [
      {'title': 'Mon Compte', 'icon': Icons.account_circle, 'onTap': () {}},
      {'title': 'Paramètres', 'icon': Icons.settings, 'onTap': () {}},
      {
        'title': 'Déconnexion',
        'icon': Icons.logout,
        'onTap': () {
          _showLogoutConfirmationDialog(context);
        }
      }
    ];
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text(
          'inTime',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mois',
                    style: TextStyle(fontSize: 25, color: Colors.teal),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 5.0, bottom: 15.0, left: 15.0, right: 15.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: monthScreen(mois: mois),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jours',
                    style: TextStyle(fontSize: 25, color: Colors.teal),
                  ),
                ],
              ),
            ),
            Container(
              child: TableCalendar(
                locale: 'en_US',
                rowHeight: 43,
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day) => isSameDay(day, today),
                onDaySelected: _onDaySelected,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: const CalendarStyle(
                  todayTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                  selectedDecoration: BoxDecoration(
                      shape: BoxShape.rectangle, color: Colors.teal),
                  outsideDaysVisible: false,
                ),
                focusedDay: today,
                firstDay: DateTime.utc(2017, 12, 10),
                lastDay: DateTime.utc(2030, 11, 20),
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: 300,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.teal,
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 4,
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: _selectedImage != null
                              ? CircleAvatar(
                                  backgroundImage: FileImage(
                                    _selectedImage!,
                                  ),
                                )
                              : const Center(child: Text('Select Image')),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 1, color: Colors.white),
                              color: Colors.teal,
                            ),
                            child: IconButton(
                                onPressed: () {
                                  _pickImage();
                                },
                                icon: const Icon(Icons.edit)),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.userConnect,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    var item = drawerList[index];

                    return ListTile(
                      title: Text(item['title']),
                      leading: Icon(item['icon']),
                      onTap: item['onTap'],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                  itemCount: drawerList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _pickImage() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnImage == null) return;
    setState(() {
      _selectedImage = File(returnImage!.path);
    });
  }
}

// ignore: camel_case_types
class monthScreen extends StatelessWidget {
  const monthScreen({
    Key? key,
    required this.mois,
  }) : super(key: key);

  final List<String> mois;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: mois.length,
        separatorBuilder: (BuildContext context, int i) {
          return const SizedBox(
            width: 5,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 120,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                minimumSize: const Size(50, 5),
                backgroundColor:
                    (DateTime.now().month == mois.indexOf(mois[index]) + 1)
                        ? Colors.white
                        : Colors.teal,
              ),
              onPressed: () {},
              child: Text(
                mois[index],
                style: TextStyle(
                  color: (DateTime.now().month == mois.indexOf(mois[index]) + 1)
                      ? Colors.teal
                      : Colors.white,
                ),
              ),
            ),
          );
        });
  }
}

class elements extends StatelessWidget {
  const elements({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final String title;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          Text(
            title,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

/// le profil utilisateur et les paramètres dans le drawer, ainsi qu'une boîte de dialogue de confirmation de déconnexion
void _showLogoutConfirmationDialog(BuildContext context) {
  Future<void> _logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('connected', false);
    Navigator.pushReplacementNamed(context, LoginPage.id);
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Confirmation',
          style: TextStyle(
            color: Colors.teal, // Couleur du texte du titre
          ),
        ),
        content: const Text(
          'Êtes-vous sûr de vouloir vous déconnecter ?',
          style: TextStyle(
            color: Colors.black, // Couleur du texte du contenu
          ),
        ),
        backgroundColor:
            Colors.white, // Couleur de fond de la boîte de dialogue
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Bordure arrondie
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fermer la boîte de dialogue
            },
            child: const Text(
              'Annuler',
              style: TextStyle(
                color: Colors.teal, // Couleur du texte du bouton
              ),
            ),
          ),
          TextButton(
            onPressed: _logOut,
            child: Text(
              'Déconnecter',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}
