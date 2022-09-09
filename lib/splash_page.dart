import 'dart:async';

import 'package:ewms_app/root_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  int _currentTime = 3;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime--;
      });
      if (_currentTime == 0) {
        _jumpRootPage();
      }
    });
  }

  void _jumpRootPage() {
    _timer?.cancel();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => RootPage()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(
          "assets/images/splash.png",
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          right: 10,
          child: InkWell(child: _childButton(), onTap: _jumpRootPage),
        )
      ],
    ));
  }

// 跳过按钮
  Widget _childButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 50,
        height: 50,
        color: Colors.black12,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '跳过',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              '${_currentTime}s',
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
