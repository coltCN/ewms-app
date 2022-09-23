class Goods {
  String? id;
  String? materialCode;
  String? materialName;
  String? barcode;
  String? unit;
  String? specification;

  Goods({
    this.id,
    this.materialCode,
    this.materialName,
    this.unit,
    this.barcode,
    this.specification,
  });

  factory Goods.fromJson(dynamic data) {
    return Goods(
      id: data['id'],
      materialCode: data['materialCode'],
      materialName: data['materialName'],
      barcode: data['barcode'],
      unit: data['unit'],
      specification: data['specification'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'materialCode': materialCode,
        'materialName': materialName,
        'barcode': barcode,
        'unit': unit,
        'specification': specification,
      };
}
