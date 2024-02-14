class GetCustForSortingReq {
  String? cBRANCD;
  String? cGRPCD;
  String? cVEHICD;
  String? cRTECD;

  GetCustForSortingReq({this.cBRANCD, this.cGRPCD, this.cVEHICD, this.cRTECD});

  GetCustForSortingReq.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cGRPCD = json['cGRPCD'];
    cVEHICD = json['cVEHICD'];
    cRTECD = json['cRTECD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['cGRPCD'] = this.cGRPCD;
    data['cVEHICD'] = this.cVEHICD;
    data['cRTECD'] = this.cRTECD;
    return data;
  }
}