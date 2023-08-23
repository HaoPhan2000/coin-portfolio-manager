class TransactionModel {
  TransactionModel(
      {required this.id,
      required this.price,
      required this.total,
      required this.quantity,
      required this.time,
      required this.type});

  late String id;
  late num price;
  late num total;
  late num quantity;
  late String time;
  late String type;
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['price'] = price;
    data['total'] = total;
    data['time'] = time;
    data['type'] = type;
    return data;
  }
}
