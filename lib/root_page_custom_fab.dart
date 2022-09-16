import 'package:ewms_app/view/home.dart';
import 'package:ewms_app/view/in_store.dart';
import 'package:ewms_app/widget/expandable_fab.dart';
import 'package:ewms_app/widget/fab/fab_bottom_app_bar.dart';
import 'package:ewms_app/widget/fab/fab_with_icons.dart';
import 'package:ewms_app/widget/sector_expandable_fab.dart';
import 'package:flutter/material.dart';

import 'view/out_store.dart';
import 'view/storage.dart';
import 'widget/fab/layout.dart';

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
      bottomNavigationBar: FABBottomAppBar(
        // centerItemText: 'A',
        color: Colors.grey,
        selectedColor: Theme.of(context).primaryColor,
        notchedShape: const CircularNotchedRectangle(),
        onTabSelected: _selectedTab,
        items: [
          FABBottomAppBarItem(iconData: Icons.menu, text: 'This'),
          FABBottomAppBarItem(iconData: Icons.layers, text: 'Is'),
          FABBottomAppBarItem(iconData: Icons.dashboard, text: 'Bottom'),
          FABBottomAppBarItem(iconData: Icons.info, text: 'Bar'),
        ],
      ),
      floatingActionButton: _buildFab(context),
      // floatingActionButton: SectorExpandableFab(
      //   children: [
      //     IconButton(
      //         onPressed: () {},
      //         icon: Image.asset(
      //           "assets/images/in_store.png",
      //           width: 20,
      //         )),
      //     IconButton(
      //         onPressed: () {},
      //         icon: Image.asset(
      //           "assets/images/out_store.png",
      //           width: 20,
      //         )),
      //     IconButton(
      //         onPressed: () {},
      //         icon: Image.asset(
      //           "assets/images/goods.png",
      //           width: 20,
      //         )),
      //   ],
      // ),
      // floatingActionButton: ExpandableFab(
      //   distance: 112.0,
      //   children: [
      //     ActionButton(
      //         onPressed: () {},
      //         icon: Image.asset(
      //           "assets/images/in_store.png",
      //           width: 20,
      //         )),
      //     ActionButton(
      //         onPressed: () {},
      //         icon: Image.asset(
      //           "assets/images/out_store.png",
      //           width: 20,
      //         )),
      //     ActionButton(
      //         onPressed: () {},
      //         icon: Image.asset(
      //           "assets/images/goods.png",
      //           width: 20,
      //         )),
      //   ],
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void selectBottomButton(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  Widget _buildFab(BuildContext context) {
    final icons = [Icons.sms, Icons.mail, Icons.phone];
    return AnchoredOverlay(
      showOverlay: true,
      overlayBuilder: (context, offset) {
        return CenterAbout(
          position: Offset(offset.dx, offset.dy - icons.length * 35.0),
          child: FabWithIcons(
            icons: icons,
            onIconTapped: _selectedFab,
          ),
        );
      },
      child: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {},
        // elevation: 2.0,
        child: const Icon(Icons.home),
      ),
    );
  }

  void _selectedTab(int value) {}

  void _selectedFab(int value) {}
}
