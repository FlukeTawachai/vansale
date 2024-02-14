class SupOrderDetailFields {
  static final List<String> values = [
    /// Add all fields
    id, orderId, name, number, price, amount, img
  ];

  static final String id = 'id';
  static final String orderId = 'order_id';
  static final String name = 'name';
  static final String number = 'number';
  static final String price = 'price';
  static final String amount = 'amount';
  static final String img = 'img';
}

class SupOrderDetailModel {
  int id;
  int orderId;
  String name;
  int number;
  double price;
  double amount;
  String img;

  SupOrderDetailModel({
    this.id,
    this.orderId,
    this.name,
    this.number,
    this.price,
    this.amount,
    this.img,
  });

  SupOrderDetailModel.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        orderId = res["order_id "],
        name = res["name"],
        number = res["number"],
        price = res["price"],
        amount = res["amount"],
        img = res["img"];

  static supOrderDetailfromJson(Map<String, Object> json) => SupOrderDetailModel(
        id: json[SupOrderDetailFields.id] as int,
        orderId: json[SupOrderDetailFields.orderId] as int,
        name: json[SupOrderDetailFields.name] as String,
        number: json[SupOrderDetailFields.number] as int,
        price: json[SupOrderDetailFields.price] as double,
        amount: json[SupOrderDetailFields.amount] as double,
        img: json[SupOrderDetailFields.img] as String,
      );

  Map<String, Object> toMap() {
    return {
      'id': id,
      'order_id': orderId,
      'name': name,
      'number': number,
      'price': price,
      'amount': amount,
      'img': img,
    };
  }
}
