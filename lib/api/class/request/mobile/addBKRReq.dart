class AddBKRReq {
  String? cREFDOC;
  String? cBASKCD;
  double? iQTY;
  double? iTOTAL;
  String? cTYPE;
  String? cSENDER;
  String? cRECEIVER;
  String? cBRANCD;
  String? cVEHICD;
  String? cGRPCD;
  String? cRTECD;
  String? cCREABY;

  AddBKRReq(
      {this.cREFDOC,
      this.cBASKCD,
      this.iQTY,
      this.iTOTAL,
      this.cTYPE,
      this.cSENDER,
      this.cRECEIVER,
      this.cBRANCD,
      this.cVEHICD,
      this.cGRPCD,
      this.cRTECD,
      this.cCREABY});

  AddBKRReq.fromJson(Map<String, dynamic> json) {
    cREFDOC = json['cREF_DOC'];
    cBASKCD = json['cBASKCD'];
    iQTY = json['iQTY'];
    iTOTAL = json['iTOTAL'];
    cTYPE = json['cTYPE'];
    cSENDER = json['cSENDER'];
    cRECEIVER = json['cRECEIVER'];
    cBRANCD = json['cBRANCD'];
    cVEHICD = json['cVEHICD'];
    cGRPCD = json['cGRPCD'];
    cRTECD = json['cRTECD'];
    cCREABY = json['cCREABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cREF_DOC'] = this.cREFDOC;
    data['cBASKCD'] = this.cBASKCD;
    data['iQTY'] = this.iQTY;
    data['iTOTAL'] = this.iTOTAL;
    data['cTYPE'] = this.cTYPE;
    data['cSENDER'] = this.cSENDER;
    data['cRECEIVER'] = this.cRECEIVER;
    data['cBRANCD'] = this.cBRANCD;
    data['cVEHICD'] = this.cVEHICD;
    data['cGRPCD'] = this.cGRPCD;
    data['cRTECD'] = this.cRTECD;
    data['cCREABY'] = this.cCREABY;
    return data;
  }
}