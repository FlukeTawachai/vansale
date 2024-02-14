class GetSupplierOrderReq {
  String cBRANCD;
  String dPODATE;

  GetSupplierOrderReq({this.cBRANCD, this.dPODATE});

  GetSupplierOrderReq.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    dPODATE = json['dPODATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['dPODATE'] = this.dPODATE;
    return data;
  }
}