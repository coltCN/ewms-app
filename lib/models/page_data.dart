class PageData<T> {
  int pageIndex;
  int pageSize;
  int total;
  List<T> data;
  PageData({
    required this.pageIndex,
    required this.pageSize,
    required this.total,
    required this.data,
  });

  factory PageData.fromJson(dynamic data) {
    return PageData(
      pageIndex: data['pageIndex'],
      pageSize: data['pageSize'],
      total: data['total'],
      data: data['data'],
    );
  }
}
