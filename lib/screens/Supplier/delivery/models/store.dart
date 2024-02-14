class StoreFields {
  static final List<String> values = [
    /// Add all fields
    id, image, name, address, addressname, time, contact, phone, total, no, amount, wholesaleStore
  ];

  static final String id = 'id';
  static final String image = 'image';
  static final String name = 'name';
  static final String address = 'address';
  static final String addressname = 'addressname';
  static final String time = 'time';
  static final String contact = 'contact';
  static final String phone = 'phone';
  static final String total = 'total';
  static final String no = 'no';
  static final String amount = 'amount';
  static final String wholesaleStore = 'wholesaleStore';
}

class StoreModel {
  final int? id;
  final String? image;
  final String? name;
  final String? address;
  final String? addressname;
  final String? time;
  final String? contact;
  final String? phone;
  final String? total;
  final String? no;
  final double? amount;
  final bool? wholesaleStore;

  StoreModel({
    this.id,
    this.image,
    this.name,
    this.address,
    this.addressname,
    this.time,
    this.contact,
    this.phone,
    this.total,
    this.no,
    this.amount,
    this.wholesaleStore
  });

  StoreModel.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        image = res["image"],
        name = res["name"],
        address = res["address"],
        addressname = res["addressname"],
        time = res["time"],
        contact = res["contact"],
        phone = res["phone"],
        total = res["total"],
        no = res["no"],
        amount = res["amount"],
        wholesaleStore = res["wholesaleStore"];

  static StoreModelfromJson(Map<String, Object> json) => StoreModel(
        id: json[StoreFields.id] as int,
        image: json[StoreFields.image] as String,
        name: json[StoreFields.name] as String,
        address: json[StoreFields.address] as String,
        addressname: json[StoreFields.addressname] as String,
        time: json[StoreFields.time] as String,
        contact: json[StoreFields.contact] as String,
        phone: json[StoreFields.phone] as String,
        total: json[StoreFields.total] as String,
        no: json[StoreFields.no] as String,
        amount: json[StoreFields.amount] as double,
        wholesaleStore: json[StoreFields.wholesaleStore] as bool,
      );

  Map<String, Object> toMap() {
    return {
      'id': id!,
      'image': image!,
      'name': name!,
      'address': address!,
      'addressname': addressname!,
      'time': time!,
      'contact': contact!,
      'phone': phone!,
      'total': total!,
      'no': no!,
      'amount': amount!,
      'wholesaleStore' : wholesaleStore!
    };
  }
}
