import 'package:demo_app/utils/comman/app_botton.dart';
import 'package:demo_app/utils/comman/app_color.dart';
import 'package:demo_app/utils/comman/app_text.dart';
import 'package:demo_app/utils/comman/comman_text.dart';
import 'package:demo_app/view/home/second_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text(
          AppText.HomePageName,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => SecondScren(
                                    image: "images/Rectangle 391.png",
                                  )));
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColor.primeryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: GlobleText(
                          text: AppText.name,
                          // color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColor.darkColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(AppText.name),
                    ),
                  ),
                ),
              ],
            ),
            GlobleButton(onTap: (){}),
            Container(
                height: 50,
                child: ElevatedButton(onPressed: () {}, child: Text('data')))
          ],
        ),
      ),
    );
  }
}