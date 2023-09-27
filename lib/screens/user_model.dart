import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String? id;
  final String? name;
  final int? age;
  final String? address;

  User({this.id, this.name, this.age, this.address});

  static User fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return User(
      id : snapshot['id'],
      name : snapshot['name'],
      age:  snapshot['age'],
      address: snapshot['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "age": age, "address": address};
  }
}
