class SupOrderFields {
  static final List<String> values = [
    /// Add all fields
    id, date
  ];

  static final String id = 'id';
  static final String date = 'date';
}

class SupplierOrder {
  final int id;
  final String date;

  SupplierOrder({this.id, this.date});

  SupplierOrder.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        date = res["date"];

  static supplierOrderfromJson(Map<String, Object> json) => SupplierOrder(
        id: json[SupOrderFields.id] as int,
        date: json[SupOrderFields.date] as String,
      );

  Map<String, Object> toMap() {
    return {
      'id': id,
      'date': date,
    };
  }
}
