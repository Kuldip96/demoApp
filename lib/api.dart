// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class EmployeeList extends StatefulWidget {
//   @override
//   _EmployeeListState createState() => _EmployeeListState();
// }

// class Employee {
//   int? albumId;
//   int? id;
//   String? title;
//   String? url;
//   String? thumbnailUrl;

//   Employee({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

//   Employee.fromJson(Map<String, dynamic> json) {
//     albumId = json['albumId'];
//     id = json['id'];
//     title = json['title'];
//     url = json['url'];
//     thumbnailUrl = json['thumbnailUrl'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['albumId'] = this.albumId;
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['url'] = this.url;
//     data['thumbnailUrl'] = this.thumbnailUrl;
//     return data;
//   }
// }

// Future<List<Employee>> fetchEmployees() async {
//   final response =
//       await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

//   if (response.statusCode == 200) {
//     List<dynamic> data = json.decode(response.body)['data'];
//     return data.map((json) => Employee.fromJson(json)).toList();
//   } else {
//     throw Exception('Failed to load employees');
//   }
// }

// class _EmployeeListState extends State<EmployeeList> {
//   late Future<List<Employee>> futureEmployees;

//   @override
//   void initState() {
//     super.initState();
//     futureEmployees = fetchEmployees();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: FutureBuilder<List<Employee>>(
//           future: futureEmployees,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return ListView.builder(
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                   Employee employee = snapshot.data![index];
//                   return ListTile(
//                     title: Text(employee.id.toString()),
//                     subtitle: Text(
//                       'Salary: ${employee.title}, Age: ${employee.albumId}',
//                     ),
//                   );
//                 },
//               );
//             } else if (snapshot.hasError) {
//               return Text('${snapshot.error}');
//             }
//             return CircularProgressIndicator();
//           },
//         ),
//       ),
//     );
//   }
// }
