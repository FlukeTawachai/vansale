class BasketReturnResp {
  String? cGUID;
  String? cREFDOC;
  String? cBASKCD;
  String? dREDATE;
  int? iQTY;
  String? iTOTAL;
  String? cTYPE;
  String? cSENDER;
  String? cRECEIVER;
  String? cCREABY;
  String? cUPDABY;
  String? dCREADT;
  String? dUPDADT;
  String? cBRANCD;
  String? cVEHICD;
  String? cGRPCD;
  String? cRTECD;
  String? cSTATUS;

  BasketReturnResp(
      {this.cGUID,
      this.cREFDOC,
      this.cBASKCD,
      this.dREDATE,
      this.iQTY,
      this.iTOTAL,
      this.cTYPE,
      this.cSENDER,
      this.cRECEIVER,
      this.cCREABY,
      this.cUPDABY,
      this.dCREADT,
      this.dUPDADT,
      this.cBRANCD,
      this.cVEHICD,
      this.cGRPCD,
      this.cRTECD,
      this.cSTATUS});

  BasketReturnResp.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
    cREFDOC = json['cREF_DOC'];
    cBASKCD = json['cBASKCD'];
    dREDATE = json['dREDATE'];
    iQTY = json['iQTY'];
    iTOTAL = json['iTOTAL'];
    cTYPE = json['cTYPE'];
    cSENDER = json['cSENDER'];
    cRECEIVER = json['cRECEIVER'];
    cCREABY = json['cCREABY'];
    cUPDABY = json['cUPDABY'];
    dCREADT = json['dCREADT'];
    dUPDADT = json['dUPDADT'];
    cBRANCD = json['cBRANCD'];
    cVEHICD = json['cVEHICD'];
    cGRPCD = json['cGRPCD'];
    cRTECD = json['cRTECD'];
    cSTATUS = json['cSTATUS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    data['cREF_DOC'] = this.cREFDOC;
    data['cBASKCD'] = this.cBASKCD;
    data['dREDATE'] = this.dREDATE;
    data['iQTY'] = this.iQTY;
    data['iTOTAL'] = this.iTOTAL;
    data['cTYPE'] = this.cTYPE;
    data['cSENDER'] = this.cSENDER;
    data['cRECEIVER'] = this.cRECEIVER;
    data['cCREABY'] = this.cCREABY;
    data['cUPDABY'] = this.cUPDABY;
    data['dCREADT'] = this.dCREADT;
    data['dUPDADT'] = this.dUPDADT;
    data['cBRANCD'] = this.cBRANCD;
    data['cVEHICD'] = this.cVEHICD;
    data['cGRPCD'] = this.cGRPCD;
    data['cRTECD'] = this.cRTECD;
    data['cSTATUS'] = this.cSTATUS;
    return data;
  }
}
