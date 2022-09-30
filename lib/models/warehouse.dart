import 'dart:convert';

T? asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class Warehouse {
  Warehouse({
    this.id,
    this.createTime,
    this.creatorId,
    this.modifyTime,
    this.modifierId,
    this.remark,
    required this.warehouseName,
    this.creatorName,
    this.modifierName,
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) => Warehouse(
        id: asT<String?>(json['id']),
        createTime: asT<int?>(json['createTime']),
        creatorId: asT<String?>(json['creatorId']),
        modifyTime: asT<int?>(json['modifyTime']),
        modifierId: asT<String?>(json['modifierId']),
        remark: asT<String?>(json['remark']),
        warehouseName: asT<String>(json['warehouseName'])!,
        creatorName: asT<String?>(json['creatorName']),
        modifierName: asT<String?>(json['modifierName']),
      );

  String? id;
  int? createTime;
  String? creatorId;
  int? modifyTime;
  String? modifierId;
  String? remark;
  String warehouseName;
  String? creatorName;
  String? modifierName;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'createTime': createTime,
        'creatorId': creatorId,
        'modifyTime': modifyTime,
        'modifierId': modifierId,
        'remark': remark,
        'warehouseName': warehouseName,
        'creatorName': creatorName,
        'modifierName': modifierName,
      };
}
