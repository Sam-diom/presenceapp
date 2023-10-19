import 'dart:convert';

class MongoModel {
  Object id;
  String firstName;
  String lastName;
  String email;
  String password;
  DateTime created;

  MongoModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.created,
  });

  factory MongoModel.fromRawJson(String str) =>
      MongoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MongoModel.fromJson(Map<String, dynamic> json) => MongoModel(
      id: json["_id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      password: json["password"],
      created: DateTime.parse(json["created"]));

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "created": created.toIso8601String(),
      };

  static MongoModel createNew({
    required Object id,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required DateTime created,
  }) {
    return MongoModel(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        created: DateTime.now()
      );
  }

  static fromMap(Map<String, dynamic> userDocument) {}
}
