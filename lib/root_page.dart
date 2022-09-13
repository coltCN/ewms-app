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
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  final List<String> _titles = ["首页", "入库", "出库", "库存"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        children: [
          HomePage(),
          InStorePage(),
          OutStorePage(),
          StoragePage(),
        ],
        onPageChanged: (value) => {
          setState(() {
            _currentIndex = value;
          })
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: IconButton(
                onPressed: () {
                  selectBottomButton(0);
                },
                icon: Image.asset(
                  "assets/images/home.png",
                ),
                selectedIcon: Image.asset("assets/images/home_active.png"),
                isSelected: _currentIndex == 0,
              ),
            ),
            SizedBox(
              width: 40,
              height: 40,
              child: IconButton(
                onPressed: () {
                  selectBottomButton(1);
                },
                icon: Image.asset("assets/images/in_store.png"),
                selectedIcon: Image.asset("assets/images/in_store_active.png"),
                isSelected: _currentIndex == 1,
              ),
            ),
            const SizedBox(),
            SizedBox(
              width: 40,
              height: 40,
              child: IconButton(
                onPressed: () {
                  selectBottomButton(2);
                },
                icon: Image.asset("assets/images/out_store.png"),
                selectedIcon: Image.asset("assets/images/out_store_active.png"),
                isSelected: _currentIndex == 2,
              ),
            ),
            SizedBox(
              width: 40,
              height: 40,
              child: IconButton(
                onPressed: () {
                  selectBottomButton(3);
                },
                icon: Image.asset("assets/images/goods.png"),
                selectedIcon: Image.asset("assets/images/goods_active.png"),
                isSelected: _currentIndex == 3,
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
        shape: CircularNotchedRectangle(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        shape: const CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void selectBottomButton(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.jumpToPage(index);
    });
  }
}
