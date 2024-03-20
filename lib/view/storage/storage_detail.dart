import 'package:flutter/material.dart';

class StorageDetail extends StatelessWidget {
  Map<String, dynamic> userdata;
  StorageDetail({super.key, required this.userdata});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.network(
              userdata['profilepic'],
              fit: BoxFit.fill,
            ),
          ),
          Text(
            "Name: ${userdata["name"]}",
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text(
            "Email: ${userdata["email"]}",
            style: const TextStyle(
              fontSize: 25,
            ),
          ),
          Text(
            "Age: ${userdata['age'].toString()}",
            style: const TextStyle(
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }
}
