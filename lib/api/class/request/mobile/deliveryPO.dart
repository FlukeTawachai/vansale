class DeliveryPOReq {
  String cPOCD;
  String cUPDABY;

  DeliveryPOReq({this.cPOCD, this.cUPDABY});

  DeliveryPOReq.fromJson(Map<String, dynamic> json) {
    cPOCD = json['cPOCD'];
    cUPDABY = json['cUPDABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cPOCD'] = this.cPOCD;
    data['cUPDABY'] = this.cUPDABY;
    return data;
  }
}