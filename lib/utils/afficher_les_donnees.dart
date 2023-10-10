// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../bdHelper/mongoBdConnect.dart';
import '../login_screen.dart';
import '../mongodbModel.dart';

class MongoDbDisplay extends StatefulWidget {
  const MongoDbDisplay({
    Key? key,
    required this.userConnect,
  }) : super(key: key);
  final String userConnect;

  @override
  State<MongoDbDisplay> createState() => _MongoDbDisplayState();
}

class _MongoDbDisplayState extends State<MongoDbDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bonjour ${widget.userConnect}"),
        actions: [
          IconButton(
              onPressed: () async {
                await MongoDatabase.db.close();
                MaterialPageRoute newRoute = MaterialPageRoute(
                    builder: (context) => const LoginPage(
                          title: 'MyPresence',
                        ));
                Navigator.pushReplacement(context, newRoute);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
            future: MongoDatabase.getData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData) {
                  var totalDta = snapshot.data.length;
                  print("Total data $totalDta");
                  return ListView.builder(
                      itemCount: totalDta,
                      itemBuilder: (context, index) {
                        return displayCard(
                            MongoModel.fromJson(snapshot.data[index]));
                      });
                } else {
                  return const Center(child: Text("No Datta Avaible."));
                }
              }
            }),
      )),
    );
  }

  Widget displayCard(MongoModel data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.id.toString()),
            const SizedBox(
              height: 5.0,
            ),
            Text(data.firstName),
            Text(data.lastName),
            Text(data.email)
          ],
        ),
      ),
    );
  }
}
