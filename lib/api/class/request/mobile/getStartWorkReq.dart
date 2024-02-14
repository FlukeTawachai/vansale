class GetStartWorkReq {
  String? cBRANCD;
  String? cUSRNM;
  String? cSECTION;
  String? dINVENTDT;

  GetStartWorkReq({this.cBRANCD, this.cUSRNM, this.cSECTION, this.dINVENTDT});

  GetStartWorkReq.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cUSRNM = json['cUSRNM'];
    cSECTION = json['cSECTION'];
    dINVENTDT = json['dINVENT_DT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['cUSRNM'] = this.cUSRNM;
    data['cSECTION'] = this.cSECTION;
    data['dINVENT_DT'] = this.dINVENTDT;
    return data;
  }
}