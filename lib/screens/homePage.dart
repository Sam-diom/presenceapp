import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const String id = 'home';
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {

    List<String> month = [
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

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 26, 34, 45),
        appBar: AppBar(
          title: const Text('Presence App'),
        ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: month.length,
                      separatorBuilder:(BuildContext context, int i){
                        return SizedBox(width: 5,);
                      },
                      itemBuilder: (BuildContext context, int index){
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(50, 5)
                          ),
                          onPressed: (){}, 
                          child: Text(month[index]),
                          );
              
                      }
                      ),
              ),
              ), 
              Text(
                'Days',
                style: TextStyle(
                 fontSize: 25,
                 color: Colors.white
                ),
                ),
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 540,
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: days.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index){
                      return Card(
                        margin: EdgeInsets.all(15),
                        elevation: 4,
                        child: Center(
                          child: Text(days[index])
                          ),
                      );
                    },
                    ),
                    
                ),
              )
             
           ],
            
        ),
        ),
        drawer: Drawer(
          child: DrawerHeader(
            child: Container(
              width: 200,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.account_balance),
                  ),
                  Text('Nafo Noura')
                ],
              ),

            )
            ),
        ),
        bottomNavigationBar: Container(
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 20,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'Presence'),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Accueil'),
              BottomNavigationBarItem(
                icon: Icon(Icons.qr_code),
                label: 'Scanner'),
            ]
            ),
        ),
      );

    
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
       color: Colors.blue,
       borderRadius: BorderRadius.circular(15)
     ),
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         icon,
         Text(title, style: const TextStyle(
           fontSize: 20,
           color: Colors.white
         ),),
       ],
     ),
    );
  }
}