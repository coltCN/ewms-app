import 'package:ewms_app/http/http.dart';
import 'package:ewms_app/models/response_data.dart';
import 'package:ewms_app/models/warehouse.dart';

class WarehouseService {
  static Future<ResponseData> save(Warehouse warehouse) async {
    final resp = await Http.post("/warehouse", data: warehouse);
    return ResponseData.fromJson(resp);
  }

  static Future<ResponseData> getWarehouse({int page = 1}) async {
    final resp = await Http.get('/warehouse/_query',
        params: {'pageSize': 10, 'pageIndex': page});
    return ResponseData.fromJson(resp);
  }
}
