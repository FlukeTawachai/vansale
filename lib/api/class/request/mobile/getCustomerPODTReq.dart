class GetCustomerPODTReq {
  String? cPOCD;
  String? cCUSTTYPE;

  GetCustomerPODTReq({this.cPOCD, this.cCUSTTYPE});

  GetCustomerPODTReq.fromJson(Map<String, dynamic> json) {
    cPOCD = json['cPOCD'];
    cCUSTTYPE = json['cCUSTTYPE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cPOCD'] = this.cPOCD;
    data['cCUSTTYPE'] = this.cCUSTTYPE;
    return data;
  }
}