import 'package:easy_refresh/easy_refresh.dart';
import 'package:ewms_app/models/goods.dart';
import 'package:ewms_app/models/page_data.dart';
import 'package:ewms_app/services/goods_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class GoodsPage extends StatefulWidget {
  const GoodsPage({super.key});

  @override
  State<GoodsPage> createState() => _GoodsPageState();
}

class _GoodsPageState extends State<GoodsPage> {
  int _page = 1;
  int _count = 0;
  bool _hasMore = true;
  List _dataList = List.empty(growable: true);

  late EasyRefreshController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController(
      controlFinishLoad: true,
      controlFinishRefresh: true,
    );
    _refresh();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("商品管理"),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: (() {
                Navigator.pushNamed(context, "/add_goods").then((value) {
                  _controller.callRefresh();
                });
              }),
              child: Text(
                "添加",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ))
        ],
      ),
      body: EasyRefresh(
        controller: _controller,
        header: const ClassicHeader(),
        footer: const ClassicFooter(),
        onRefresh: () async {
          if (!mounted) {
            return;
          }
          await _refresh();
          _controller.finishRefresh();
          _controller.resetFooter();
        },
        onLoad: () async {
          if (!mounted) {
            return;
          }
          if (_hasMore) {
            final value = await GoodsService.getGoods(page: _page + 1);
            final result = PageData.fromJson(value);
            setState(() {
              _page = result.pageIndex;
              _count += result.data.length;
              _dataList.addAll(result.data);
            });
          }
          _controller.finishLoad(
              _hasMore ? IndicatorResult.success : IndicatorResult.noMore);
        },
        child: ListView.builder(
          itemBuilder: ((context, index) {
            final data = Goods.fromJson(_dataList[index]);
            return _rowItem(data);
          }),
          itemCount: _count,
        ),
      ),
    );
  }

  Future _refresh() async {
    final value = await GoodsService.getGoods(page: 1);
    final result = PageData.fromJson(value);
    setState(() {
      _page = 1;
      _count = result.data.length;
      _dataList = result.data;
      _hasMore = _count < result.total;
    });
  }

  Widget _rowItem(Goods goods) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {},
              icon: Icons.more_horiz,
              label: "详情",
              backgroundColor: Colors.blue,
            ),
            SlidableAction(
              onPressed: (context) {},
              icon: Icons.delete,
              label: "删除",
              backgroundColor: Colors.red,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5)),
            )
          ],
        ),
        child: Row(
          children: [
            Image.asset("assets/images/no_image.png", width: 80),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(goods.materialName ?? ""),
                  _itemDetail(goods),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _itemDetail(Goods goods) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _detailItem("商品编号", goods.materialCode ?? ""),
              _detailItem("规格", goods.specification ?? ""),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _detailItem("条形码", goods.barcode ?? ""),
              _detailItem("库存", ""),
            ],
          ),
        )
      ],
    );
  }

  Widget _detailItem(String label, String value) {
    return Row(children: [
      SizedBox(
        width: 60,
        child: Text(
          "$label:",
          style: const TextStyle(fontSize: 13, color: Colors.grey),
          textAlign: TextAlign.right,
        ),
      ),
      const SizedBox(
        width: 5,
      ),
      Text(
        value,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
    ]);
  }
}
