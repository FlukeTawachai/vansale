class CustomerAttachRequest {
  String? customerId;
  String? fileName;
  String? image;

  CustomerAttachRequest({this.customerId, this.fileName, this.image});

  CustomerAttachRequest.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    fileName = json['fileName'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this.customerId;
    data['fileName'] = this.fileName;
    data['image'] = this.image;
    return data;
  }
}
