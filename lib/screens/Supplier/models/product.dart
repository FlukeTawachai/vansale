class ProductsFields {
  static final List<String> values = [
    /// Add all fields
    id, name, uom1, uom2, uom3, promo, price,amount, orderno, img, check
  ];

  static final String id = 'id';
  static final String name = 'name';
  static final String uom1 = 'uom1';
  static final String uom2 = 'uom2';
  static final String uom3 = 'uom3';
  static final String promo = 'promo';
  static final String price = 'price';
  static final String amount = 'amount';
  static final String orderno = 'orderno';
  static final String img = 'img';
  static final String check = 'check';
}

class ProductsModel {
  final int id;
  final String name;
  final String uom1;
  final String uom2;
  final String uom3;
  final String promo;
  final double price;
  final double amount;
  final String orderno;
  final String img;
  final bool check;

  ProductsModel({
    this.id,
    this.name,
    this.uom1,
    this.uom2,
    this.uom3,
    this.promo,
    this.price,
    this.amount,
    this.orderno,
    this.img,
    this.check
  });

  ProductsModel.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        uom1 = res["uom1"],
        uom2 = res["uom2"],
        uom3 = res["uom3"],
        promo = res["promo"],
        price = res["price"],
        amount = res["amount"],
        orderno = res["orderno"],
        img = res["img"],
        check = res["check"];

  static productsfromJson(Map<String, Object> json) => ProductsModel(
        id: json[ProductsFields.id] as int,
        name: json[ProductsFields.name] as String,
        uom1: json[ProductsFields.uom1] as String,
        uom2: json[ProductsFields.uom2] as String,
        uom3: json[ProductsFields.uom3] as String,
        promo: json[ProductsFields.promo] as String,
        price: json[ProductsFields.price] as double,
        amount: json[ProductsFields.amount] as double,
        orderno: json[ProductsFields.orderno] as String,
        img: json[ProductsFields.img] as String,
        check: json[ProductsFields.check] as bool,
      );

  Map<String, Object> toMap() {
    return {
      'id': id,
      'name': name,
      'uom1': uom1,
      'uom2': uom2,
      'uom3': uom3,
      'promo': promo,
      'price': price,
      'amount': amount,
      'orderno': orderno,
      'img': img,
      'check': check,
    };
  }
}
