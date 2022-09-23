import 'package:flutter/material.dart';

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
              Image.asset("assets/images/no_image.png", width: 80),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("商品1"),
                    Text(
                      "商品编号：",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      "规格：",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      "条形码：",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      "库存：",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
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
