import 'dart:math';

import 'package:dio/dio.dart';
import 'package:ewms_app/http/http.dart';
import 'package:ewms_app/models/goods.dart';
import 'package:ewms_app/models/response_data.dart';

class GoodsService {
  static Future getGoods({int page = 1}) async {
    final resp = await Http.get('/material/_query',
        params: {'pageSize': 10, 'pageIndex': page});
    return ResponseData.fromJson(resp).result;
  }

  static Future<ResponseData> addGoods(Goods data) async {
    final resp = await Http.post("/material", data: data);
    return ResponseData.fromJson(resp);
  }
}
