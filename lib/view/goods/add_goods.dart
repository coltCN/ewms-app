import 'package:ewms_app/models/goods.dart';
import 'package:ewms_app/services/goods_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddGoodsPage extends StatefulWidget {
  const AddGoodsPage({super.key});

  @override
  State<AddGoodsPage> createState() => _AddGoodsPageState();
}

class _AddGoodsPageState extends State<AddGoodsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Goods _goods = Goods();

  void _save() {
    var form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      GoodsService.addGoods(_goods);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("添加商品"),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: _save,
              child: Text(
                "保存",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ))
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text("商品编号"),
                  const SizedBox(width: 10),
                  Expanded(
                    child: const TextField(
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintText: "系统自动生成",
                        enabled: false,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text("商品名称"),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.right,
                      decoration: const InputDecoration(
                        hintText: "请输入",
                      ),
                      validator: (val) =>
                          val?.isEmpty ?? false ? '请输入商品名称' : null,
                      onSaved: (newValue) {
                        _goods.materialName = newValue;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text("商品条形码"),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.right,
                      decoration: const InputDecoration(
                        hintText: "请输入",
                      ),
                      onSaved: (val) {
                        _goods.barcode = val;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                      icon: const Icon(FontAwesomeIcons.barcode),
                      onPressed: () {}),
                ],
              ),
            ),
            const Divider(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text("规格型号"),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.right,
                      decoration: const InputDecoration(
                        hintText: "请输入",
                      ),
                      onSaved: (val) {
                        _goods.specification = val;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text("计量单位"),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      textAlign: TextAlign.right,
                      decoration: const InputDecoration(
                        hintText: "请输入",
                      ),
                      onSaved: (val) {
                        _goods.unit = val;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
