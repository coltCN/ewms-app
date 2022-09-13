import 'package:ewms_app/view/home.dart';
import 'package:ewms_app/view/in_store.dart';
import 'package:flutter/material.dart';

import 'view/out_store.dart';
import 'view/storage.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          HomePage(),
          InStorePage(),
          OutStorePage(),
          StoragePage(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    _pageController.jumpToPage(0);
                  });
                },
                icon: Image.asset("assets/images/home.png")),
            IconButton(
                onPressed: () {
                  setState(() {
                    _pageController.jumpToPage(1);
                  });
                },
                icon: Image.asset("assets/images/in_store.png")),
            const SizedBox(),
            IconButton(
                onPressed: () {
                  setState(() {
                    _pageController.jumpToPage(2);
                  });
                },
                icon: Image.asset("assets/images/out_store.png")),
            IconButton(
                onPressed: () {
                  setState(() {
                    _pageController.jumpToPage(3);
                  });
                },
                icon: Image.asset("assets/images/goods.png")),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
        shape: CircularNotchedRectangle(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
