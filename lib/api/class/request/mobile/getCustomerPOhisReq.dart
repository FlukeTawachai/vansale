class GetCustomerPOHisReq {
  String? cCUSTCD;
  String? cPOCD;

  GetCustomerPOHisReq({this.cCUSTCD, this.cPOCD});

  GetCustomerPOHisReq.fromJson(Map<String, dynamic> json) {
    cCUSTCD = json['cCUSTCD'];
    cPOCD = json['cPOCD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cCUSTCD'] = this.cCUSTCD;
    data['cPOCD'] = this.cPOCD;
    return data;
  }
}