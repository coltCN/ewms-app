import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GoodsPage extends StatefulWidget {
  const GoodsPage({super.key});

  @override
  State<GoodsPage> createState() => _GoodsPageState();
}

class _GoodsPageState extends State<GoodsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("商品管理"),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: (() {
                Navigator.pushNamed(context, "/add_goods");
              }),
              child: Text(
                "添加",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ))
        ],
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Image.asset("/assets/images/no_image.png"),
              Expanded(
                child: Column(
                  children: [
                    Text("商品1"),
                    Text("商品编号："),
                    Text("规格："),
                    Text("条形码："),
                    Text("库存："),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
