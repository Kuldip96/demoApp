import 'package:flutter/material.dart';

// ignore: must_be_immutable
class GlobleText extends StatelessWidget {
  final String text;
  String? fontFamily;
  Color? color;
  GlobleText({super.key, required this.text, this.fontFamily, this.color});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: color ?? Colors.red,
        fontFamily: fontFamily ?? 'Roboto',
      ),
    );
  }
}
