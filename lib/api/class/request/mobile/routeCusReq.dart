class RouteCusReq {
  String? cBRANCD;
  String? cRTECD;
  String? cGRPCD;
  String? dSHIPDATE;
  bool? cUSEDT;

  RouteCusReq(
      {this.cBRANCD, this.cRTECD, this.cGRPCD, this.dSHIPDATE, this.cUSEDT});

  RouteCusReq.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cRTECD = json['cRTECD'];
    cGRPCD = json['cGRPCD'];
    dSHIPDATE = json['dSHIPDATE'];
    cUSEDT = json['cUSEDT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['cRTECD'] = this.cRTECD;
    data['cGRPCD'] = this.cGRPCD;
    data['dSHIPDATE'] = this.dSHIPDATE;
    data['cUSEDT'] = this.cUSEDT;
    return data;
  }
}