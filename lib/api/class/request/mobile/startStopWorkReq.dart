class StartStopWorkReq {
  String? cBRANCD;
  String? cREFCD;
  String? cUSRNM;
  String? cSTATUS;
  String? cPLATE;
  int? iMILE;
  String? cSECTION;
  String? cCREABY;

  StartStopWorkReq(
      {this.cBRANCD,
      this.cREFCD,
      this.cUSRNM,
      this.cSTATUS,
      this.cPLATE,
      this.iMILE,
      this.cSECTION,
      this.cCREABY});

  StartStopWorkReq.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cREFCD = json['cREFCD'];
    cUSRNM = json['cUSRNM'];
    cSTATUS = json['cSTATUS'];
    cPLATE = json['cPLATE'];
    iMILE = json['iMILE'];
    cSECTION = json['cSECTION'];
    cCREABY = json['cCREABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['cREFCD'] = this.cREFCD;
    data['cUSRNM'] = this.cUSRNM;
    data['cSTATUS'] = this.cSTATUS;
    data['cPLATE'] = this.cPLATE;
    data['iMILE'] = this.iMILE;
    data['cSECTION'] = this.cSECTION;
    data['cCREABY'] = this.cCREABY;
    return data;
  }
}