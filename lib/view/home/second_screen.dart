import 'package:demo_app/utils/comman/app_color.dart';
import 'package:flutter/material.dart';

class SecondScren extends StatefulWidget {
  final String image;
  const SecondScren({super.key, required this.image});

  @override
  State<SecondScren> createState() => _SecondScrenState();
}

class _SecondScrenState extends State<SecondScren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primeryColor,
      ),
      body: Image.asset(widget.image),
    );
  }
}
