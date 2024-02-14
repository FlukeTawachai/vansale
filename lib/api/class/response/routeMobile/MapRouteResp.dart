class MapRoute {
  String? cRTECD;
  String? cRTENM;
  String? cGRPCD;
  String? cBRANCD;

  MapRoute({this.cRTECD, this.cRTENM, this.cGRPCD, this.cBRANCD});

  MapRoute.fromJson(Map<String, dynamic> json) {
    cRTECD = json['cRTECD'];
    cRTENM = json['cRTENM'];
    cGRPCD = json['cGRPCD'];
    cBRANCD = json['cBRANCD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cRTECD'] = this.cRTECD;
    data['cRTENM'] = this.cRTENM;
    data['cGRPCD'] = this.cGRPCD;
    data['cBRANCD'] = this.cBRANCD;
    return data;
  }
}
