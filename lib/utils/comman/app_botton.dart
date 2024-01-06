import 'package:demo_app/utils/comman/app_color.dart';
import 'package:demo_app/utils/comman/app_text.dart';
import 'package:demo_app/utils/comman/comman_text.dart';
import 'package:flutter/material.dart';

class GlobleButton extends StatelessWidget {
  final VoidCallback onTap;
  const GlobleButton({super.key, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(AppColor.primeryColor)),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlobleText(
              text: AppText.HomePageName,
            ),
          ],
        ),
      ),
    );
  }
}
