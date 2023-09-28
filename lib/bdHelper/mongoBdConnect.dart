import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'const.dart';
import 'package:presenceapp/mongodbModel.dart';

class MongoDatabase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }

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
