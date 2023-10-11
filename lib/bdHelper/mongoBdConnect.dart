import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'const.dart';
import 'package:presenceapp/mongodbModel.dart';

class MongoDatabase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL); //creation de l'instance de base de donnée
    await db.open(); //ouvrir 
    inspect(db);// joue le rôle de print
    userCollection = db.collection(USER_COLLECTION); 
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await userCollection.find().toList();

    return arrData;
  }

  /* db.collection.find().forEach(function(doc) {
    // Votre code ici
});
 */

  static Future<String> insert(MongoModel data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Vous êtes inscrit avec succes";
      } else {
        return "Vous n'avez rien inseré";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
