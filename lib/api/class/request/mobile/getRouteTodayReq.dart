class getRouteTodayReq {
  String cVEHICD;
  String cBRANCD;
  String cRTENM;

  getRouteTodayReq({this.cVEHICD, this.cBRANCD, this.cRTENM});

  getRouteTodayReq.fromJson(Map<String, dynamic> json) {
    cVEHICD = json['cVEHICD'];
    cBRANCD = json['cBRANCD'];
    cRTENM = json['cRTENM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cVEHICD'] = this.cVEHICD;
    data['cBRANCD'] = this.cBRANCD;
    data['cRTENM'] = this.cRTENM;
    return data;
  }
}