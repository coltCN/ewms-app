import 'package:bot_toast/bot_toast.dart';
import 'package:ewms_app/root_page.dart';
import 'package:ewms_app/splash_page.dart';
import 'package:ewms_app/view/goods/add_goods.dart';
import 'package:ewms_app/view/goods/goods.dart';
import 'package:ewms_app/view/storeage/add_storage.dart';
import 'package:ewms_app/view/storeage/storage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '库存易',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          border: InputBorder.none,
        ),
      ),
      routes: {
        "/add_goods": (context) => const AddGoodsPage(),
        "/goods": (context) => const GoodsPage(),
        "/storage": (context) => const StorageListPage(),
        "/add_storage": (context) => const AddStoragePage(),
        "/splash": (context) => const Splash(),
        "/": (context) => const RootPage(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: "/splash",
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      // home: const Splash(),
    );
  }
}
