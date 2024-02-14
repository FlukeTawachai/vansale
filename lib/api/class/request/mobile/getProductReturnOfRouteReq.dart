class GetProductReturnOfRouteReq {
  String cBRANCD;
  String cGRPCD;
  String cRTECD;
  String dRETDT;

  GetProductReturnOfRouteReq(
      {this.cBRANCD, this.cGRPCD, this.cRTECD, this.dRETDT});

  GetProductReturnOfRouteReq.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cGRPCD = json['cGRPCD'];
    cRTECD = json['cRTECD'];
    dRETDT = json['dRETDT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['cGRPCD'] = this.cGRPCD;
    data['cRTECD'] = this.cRTECD;
    data['dRETDT'] = this.dRETDT;
    return data;
  }
}