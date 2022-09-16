import 'package:ewms_app/view/home.dart';
import 'package:ewms_app/view/in_store.dart';
import 'package:ewms_app/widget/expandable_fab.dart';
import 'package:ewms_app/widget/fab/fab_bottom_app_bar.dart';
import 'package:ewms_app/widget/fab/fab_with_icons.dart';
import 'package:ewms_app/widget/sector_expandable_fab.dart';
import 'package:flutter/material.dart' hide MenuItem;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:popup_menu/popup_menu.dart';

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
  GlobalKey fabKey = GlobalKey();

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
          FABBottomAppBarItem(iconData: FontAwesomeIcons.house, text: '首页'),
          FABBottomAppBarItem(
              iconData: FontAwesomeIcons.arrowRightToBracket, text: '入库'),
          FABBottomAppBarItem(
              iconData: FontAwesomeIcons.arrowRightFromBracket, text: '出库'),
          FABBottomAppBarItem(
              iconData: FontAwesomeIcons.boxesStacked, text: '库存'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const StadiumBorder(),
        key: fabKey,
        onPressed: maxColumn,
        child: const Icon(Icons.add),
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

  void maxColumn() {
    PopupMenu menu = PopupMenu(
      context: context,
      config: const MenuConfig(
          maxColumn: 3,
          backgroundColor: Colors.white70,
          lineColor: Colors.transparent),
      items: [
        MenuItem(
            title: '入库',
            image: Icon(
              FontAwesomeIcons.fileCirclePlus,
              color: Theme.of(context).primaryColor,
            )),
        MenuItem(
            title: '出库',
            image: Icon(
              FontAwesomeIcons.fileCircleMinus,
              color: Theme.of(context).primaryColor,
            )),
        MenuItem(
            title: '货物',
            image: Icon(FontAwesomeIcons.box,
                color: Theme.of(context).primaryColor)),
        MenuItem(
            title: '仓库',
            image: Icon(FontAwesomeIcons.warehouse,
                color: Theme.of(context).primaryColor)),
      ],
    );
    menu.show(widgetKey: fabKey);
  }

  void _selectedTab(int value) {
    _pageController.jumpToPage(value);
  }

  void _selectedFab(int value) {}
}
