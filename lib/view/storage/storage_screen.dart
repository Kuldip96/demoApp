import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();

  void svaeUser() {
    String name = namecontroller.text.trim();
    String email = emailcontroller.text.trim();
    if (name != "" && email != "") {
      Map<String, dynamic> userdata = {
        "name": name,
        "email": email,
      };
      namecontroller.clear();
      emailcontroller.clear();
      FirebaseFirestore.instance.collection("users").add(userdata);
      log("User created!");
    } else {
      log("Please fill all the fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: namecontroller,
            ),
            TextField(
              controller: emailcontroller,
            ),
            TextButton(
              onPressed: () {
                svaeUser();
              },
              child: const Text('Save'),
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("users").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> userdata =
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;
                          return ListTile(
                            title: Text(
                              userdata["name"],
                            ),
                            subtitle: Text(
                              userdata["email"],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Text("No Data");
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
