class RouteReq {
  String cRTENM;
  String cBRANCD;

  RouteReq({this.cRTENM, this.cBRANCD});

  RouteReq.fromJson(Map<String, dynamic> json) {
    cRTENM = json['cRTENM'];
    cBRANCD = json['cBRANCD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cRTENM'] = this.cRTENM;
    data['cBRANCD'] = this.cBRANCD;
    return data;
  }
}