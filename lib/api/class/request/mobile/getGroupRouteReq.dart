class GetGroupRouteReq {
  String cBRANCD;
  String cGRPCD;
  String cRTECD;
  String cCUSTNM;

  GetGroupRouteReq({this.cBRANCD, this.cGRPCD, this.cRTECD, this.cCUSTNM});

  GetGroupRouteReq.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cGRPCD = json['cGRPCD'];
    cRTECD = json['cRTECD'];
    cCUSTNM = json['cCUSTNM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['cGRPCD'] = this.cGRPCD;
    data['cRTECD'] = this.cRTECD;
    data['cCUSTNM'] = this.cCUSTNM;
    return data;
  }
}