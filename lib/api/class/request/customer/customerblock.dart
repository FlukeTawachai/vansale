class CustomerBlockRequest {
  String? customerID;
  String? updateUser;
  List<CustomerBlockRequestItem>? items;

  CustomerBlockRequest({this.customerID, this.updateUser, this.items});

  CustomerBlockRequest.fromJson(Map<String, dynamic> json) {
    customerID = json['customerID'];
    updateUser = json['updateUser'];
    if (json['items'] != null) {
      items = <CustomerBlockRequestItem>[];
      json['items'].forEach((v) {
        items!.add(new CustomerBlockRequestItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerID'] = this.customerID;
    data['updateUser'] = this.updateUser;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerBlockRequestItem {
  String? productCode;
  String? brandCode;

  CustomerBlockRequestItem({this.productCode, this.brandCode});

  CustomerBlockRequestItem.fromJson(Map<String, dynamic> json) {
    productCode = json['productCode'];
    brandCode = json['brandCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productCode'] = this.productCode;
    data['brandCode'] = this.brandCode;
    return data;
  }
}
