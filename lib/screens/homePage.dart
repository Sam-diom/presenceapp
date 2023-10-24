import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home';
  const HomePage({super.key, required this.userConnect});
  final String userConnect;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime today = DateTime.now();
  DateTime? _selectedDay;

  // Map<DateTime, List<Event>> event = {};

  @override
  void dispose() {
    super.dispose();
  }
  
  void _onDaySelected(DateTime Selectedday, DateTime focusDay){
      setState(() {
        today = Selectedday;
      });
    }
  @override
  Widget build(BuildContext context) {
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
      'Samedi',
    ];

    List<String> drawerList = [
      'Mon Compte',
      'Paramètres',
      'Partager',
    ];

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text(
          'inTime',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Months',
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
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Days',
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
                selectedDayPredicate: (day)=>isSameDay(day, today),
                onDaySelected: _onDaySelected,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: const CalendarStyle(
                  todayTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                  selectedDecoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.teal
                  ),
                  outsideDaysVisible: false,
                ),
                focusedDay: today ,
                firstDay: DateTime.utc(2017, 12, 10),
                lastDay: DateTime.utc(2030, 11, 20),
              )
              )
            // Expanded(
            //   child: SizedBox(
            //     width: MediaQuery.of(context).size.width,
            //     height: 540,
            //     child: GridView.builder(
            //       scrollDirection: Axis.vertical,
            //       itemCount: days.length,
            //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //           crossAxisCount: 2),
            //       itemBuilder: (BuildContext context, int index) {
            //         return Card(
            //           shape: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(20)),
            //           margin: const EdgeInsets.all(15),
            //           elevation: 4,
            //           child: Center(child: Text(days[index])),
            //         );
            //       },
            //     ),
            //   ),
            // )
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
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 26, 34, 45),
                ),
                padding: const EdgeInsets.all(10),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 45,
                      child: Icon(Icons.account_circle),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Nafo Noura',
                      style: TextStyle(color: Colors.white, fontSize: 20),
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
                      return Container(
                          child: ListTile(
                        title: Text(drawerList[index]),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward_ios),
                        ),
                      ));
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                    itemCount: drawerList.length),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: BottomNavigationBar(
           selectedItemColor: Colors.teal,
            backgroundColor: Colors.white,
            elevation: 20,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.book,
                    color: Colors.teal,
                  ),
                  label: 'Presence'),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.teal,
                ),
                label: 'Accueil',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.qr_code,
                  color: Colors.teal,
                ),
                label: 'QR code',
              ),
            ]),
      ),
    );
  }
}

class monthScreen extends StatelessWidget {
  const monthScreen({
    super.key,
    required this.mois,
  });

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
                backgroundColor: (DateTime.now().month ==
                        mois.indexOf(mois[index]) + 1)
                    ? Colors.white
                    : Colors.teal,
              ),
              onPressed: () {},
              child: Text(
                mois[index],
                style: TextStyle(
                  color: (DateTime.now().month ==
                          mois.indexOf(mois[index]) + 1)
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
    super.key,
    required this.icon,
    required this.title,
  });
  final String title;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(15)
        ),
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
