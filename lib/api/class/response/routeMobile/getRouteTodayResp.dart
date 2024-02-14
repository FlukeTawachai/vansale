class getRouteTodayResp {
  String? cBRANCD;
  String? cGRPCD;
  String? cRTECD;
  String? cRTENM;

  getRouteTodayResp({this.cBRANCD, this.cGRPCD, this.cRTECD, this.cRTENM});

  getRouteTodayResp.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cGRPCD = json['cGRPCD'];
    cRTECD = json['cRTECD'];
    cRTENM = json['cRTENM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['cGRPCD'] = this.cGRPCD;
    data['cRTECD'] = this.cRTECD;
    data['cRTENM'] = this.cRTENM;
    return data;
  }
}
