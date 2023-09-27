import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/user_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Flutter Firebase'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
                onPressed: () async {
                  // Dummy Data
                  // final databaseReference = FirebaseFirestore.instance;

                  // await databaseReference.collection('users').doc('1').set({
                  //   "username": "jhon",
                  //   "age": 45,
                  //   "address": "Peshawer"
                  // });

                  // Through Model class
                  _createUser(User(
                    name: 'Jack ',
                    age: 25,
                    address: 'Pakistan',
                  ));
                },
                child: const Text('Create Data')),
            const SizedBox(height: 10),

            StreamBuilder<List<User>>(
              stream: _readData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data!.isEmpty) {
                  return const Center(child: Text('No Data'));
                }
                final users = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: users!
                        .map((user) => ListTile(
                              title: Text(user.name!),
                              subtitle: Text(user.address!),
                            ))
                        .toList(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  // Create User
  _createUser(User user) {
    final userCollection = FirebaseFirestore.instance.collection('users');
    String id = userCollection.doc().id;

    final newUser =
        User(id: id, name: user.name, age: user.age, address: user.address)
            .toJson();

    userCollection.doc(id).set(newUser);
  }

  // Read Data
  Stream<List<User>> _readData() {
    final userCollection = FirebaseFirestore.instance.collection('users');
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => User.fromSnapshot(e)).toList());
  }
}
