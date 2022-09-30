import 'package:bruno/bruno.dart';
import 'package:ewms_app/models/warehouse.dart';
import 'package:ewms_app/services/warehouse_service.dart';
import 'package:flutter/material.dart';

class AddStoragePage extends StatefulWidget {
  const AddStoragePage({super.key});

  @override
  State<AddStoragePage> createState() => _AddStoragePageState();
}

class _AddStoragePageState extends State<AddStoragePage> {
  final TextEditingController _nameCtl = TextEditingController();
  String _nameErr = "";
  late Warehouse _warehouse;

  @override
  void initState() {
    super.initState();
    _warehouse = Warehouse(warehouseName: "");
    _nameCtl.text = _warehouse.warehouseName;
  }

  @override
  void dispose() {
    _nameCtl.dispose();
    super.dispose();
  }

  void _save(BuildContext context) {
    if (_validate()) {
      _warehouse.warehouseName = _nameCtl.text;
      WarehouseService.save(_warehouse).then((value) {
        if (value.success()) {
          Navigator.pop(context);
        }
      });
    }
  }

  bool _validate() {
    if (_nameCtl.text == '') {
      setState(() {
        _nameErr = "仓库名不能为空";
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("添加仓库"),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                _save(context);
              },
              child: const Text("保存"))
        ],
      ),
      body: Column(children: [
        BrnTextInputFormItem(
          title: "仓库名称",
          isRequire: true,
          controller: _nameCtl,
          error: _nameErr,
        )
      ]),
    );
  }
}
