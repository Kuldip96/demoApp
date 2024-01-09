import 'package:flutter/material.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  final controller = PageController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 600,
            child: PageView(
              controller: controller,
              onPageChanged: (index) {
                setState(() => isLastPage = index == 2);
              },
              children: [
                Container(
                  color: Colors.red,
                  child: Text('Page 1'),
                ),
                Container(
                  color: Colors.yellow,
                  child: Text('Page 1'),
                ),
                Container(
                  color: Colors.green,
                  child: Text('Page 1'),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: isLastPage
          ? Container(
              height: 80,
              color: Colors.amber,
            )
          : Container(
              height: 80,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      controller.jumpToPage(2);
                    },
                    child: Text('Skip'),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.nextPage(
                        duration: Duration(microseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Text('Next'),
                  ),
                ],
              ),
            ),
    );
  }
}
