import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeList extends StatefulWidget {
  @override
  _EmployeeListState createState() => _EmployeeListState();
}

// class Employee {
//   final int id;
//   final String employeeName;
//   final int employeeSalary;
//   final int employeeAge;

//   Employee({
//     required this.id,
//     required this.employeeName,
//     required this.employeeSalary,
//     required this.employeeAge,
//   });

// factory Employee.fromJson(Map<String, dynamic> json) {
//   return Employee(
//     id: json['id'],
//     employeeName: json['employee_name'],
//     employeeSalary: json['employee_salary'],
//     employeeAge: json['employee_age'],
//   );
// }
// }
class Product {
  String? sId;
  String? admin;
  List<String>? productImage;
  String? productName;
  String? role;
  int? productPrice;
  bool? isDelete;
  int? iV;

  Product(
      {this.sId,
      this.admin,
      this.productImage,
      this.productName,
      this.role,
      this.productPrice,
      this.isDelete,
      this.iV});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      sId: json['_id'],
      admin: json['admin'],
      productImage: json['productImage'].cast<String>(),
      productName: json['productName'],
      role: json['role'],
      productPrice: json['productPrice'],
      isDelete: json['isDelete'],
      iV: json['__v'],
    );
  }
}

class _EmployeeListState extends State<EmployeeList> {
  Future<List<Product>>? futureEmployees;
  String? Token;
  @override
  void initState() {
    futureEmployees = fetchEmployees();
    super.initState();
  }

  Future<List<Product>> fetchEmployees() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Token = prefs.getString('token');

    log(Token.toString());
    final response = await http.get(
      Uri.parse(
          'https://typescript-al0m.onrender.com/api/user/product/showall-product'),
      headers: {'Authorization': 'Bearer $Token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load employees');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Product>>(
          future: futureEmployees,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  Product employee = snapshot.data![index];
                  return ListTile(
                    title: Text(employee.productName.toString()),
                    subtitle: Text(
                      ' ${employee.role.toString()},     isDelete: ${employee.productPrice.toString()}',
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
