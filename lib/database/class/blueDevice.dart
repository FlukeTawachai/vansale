class BluetoothDevice {
  int? id;
  String? name;
  String? address;
  String? createDT;

  BluetoothDevice({this.id, this.name, this.address, this.createDT});

  BluetoothDevice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    createDT = json['createDT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['createDT'] = this.createDT;
    return data;
  }
}