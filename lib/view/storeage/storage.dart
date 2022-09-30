import 'package:bruno/bruno.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:ewms_app/models/page_data.dart';
import 'package:ewms_app/models/warehouse.dart';
import 'package:ewms_app/services/warehouse_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class StorageListPage extends StatefulWidget {
  const StorageListPage({super.key});

  @override
  State<StorageListPage> createState() => _StorageListPageState();
}

class _StorageListPageState extends State<StorageListPage> {
  int _page = 1;
  bool _hasMore = true;
  final List _dataList = List.empty(growable: true);

  late EasyRefreshController _controller;
  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController(
      controlFinishLoad: true,
      controlFinishRefresh: true,
    );
    _loadData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _refresh() {
    _page = 1;
    _hasMore = true;
    _dataList.clear();
    _loadData();
    _controller.finishRefresh();
    return;
  }

  void _loadData() async {
    if (_hasMore) {
      final value = await WarehouseService.getWarehouse(page: _page);
      final result = PageData.fromJson(value.result);
      _page++;
      setState(() {
        _dataList.addAll(result.data);
      });
      _hasMore = _dataList.length < result.total;
    }
    _controller.finishLoad(
        _hasMore ? IndicatorResult.success : IndicatorResult.noMore);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("仓库管理"),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/add_storage");
              },
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
        onRefresh: _refresh,
        onLoad: _loadData,
        child: ListView.builder(
            itemBuilder: ((context, index) {
              final data = Warehouse.fromJson(_dataList[index]);
              return _rowItem(data);
            }),
            itemCount: _dataList.length),
      ),
    );
  }

  Widget _rowItem(Warehouse data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                label: "编辑",
                backgroundColor: Colors.blue,
                icon: Icons.edit,
                onPressed: (context) {
                  Navigator.pushNamed(context, "/edit_storage",
                      arguments: data);
                },
              ),
              SlidableAction(
                label: "删除",
                backgroundColor: Colors.red,
                icon: Icons.delete,
                onPressed: (context) {},
              ),
            ],
          ),
          child: BrnBaseTitle(
            title: data.warehouseName,
          )),
    );
  }
}
