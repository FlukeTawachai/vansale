class AddressItemInfo {
  String name;
  String nameEN;
  String postCode;

  AddressItemInfo({this.name, this.nameEN, this.postCode});

  AddressItemInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nameEN = json['name_EN'];
    postCode = json['postCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['name_EN'] = this.nameEN;
    data['postCode'] = this.postCode;
    return data;
  }
}
