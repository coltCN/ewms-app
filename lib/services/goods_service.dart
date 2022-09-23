import 'dart:math';

import 'package:dio/dio.dart';
import 'package:ewms_app/http/http.dart';
import 'package:ewms_app/models/goods.dart';

class GoodsService {
  static Future getGoods({int page = 1}) async {
    final response = await Http.get('/material/_query',
        params: {'pageSize': 10, 'pageIndex': page});
    return response['result'];
  }

  static Future addGoods(Goods data) async {
    return await Http.post("/material", data: data);
  }
}
