class GetSaleStoreOrderReq {
  String cBRANCD;
  String cGRPCD;
  String cRTECD;
  String dPODATE;

  GetSaleStoreOrderReq({this.cBRANCD, this.cGRPCD, this.cRTECD, this.dPODATE});

  GetSaleStoreOrderReq.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cGRPCD = json['cGRPCD'];
    cRTECD = json['cRTECD'];
    dPODATE = json['dPODATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['cGRPCD'] = this.cGRPCD;
    data['cRTECD'] = this.cRTECD;
    data['dPODATE'] = this.dPODATE;
    return data;
  }
}