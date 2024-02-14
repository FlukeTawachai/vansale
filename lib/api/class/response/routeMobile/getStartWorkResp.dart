class GetStartWorkResp {
  String cGUID;
  String cBRANCD;
  String cBRANNM;
  String cUSRNM;
  String cEMPNM;
  String dINVENTDT;
  String cSTATUS;
  String cSECTION;
  String cREFCD;
  String dSTAMP;
  String cCREABY;
  String cUPDABY;
  String dCREADT;
  String dUPDADT;

  GetStartWorkResp(
      {this.cGUID,
      this.cBRANCD,
      this.cBRANNM,
      this.cUSRNM,
      this.cEMPNM,
      this.dINVENTDT,
      this.cSTATUS,
      this.cSECTION,
      this.cREFCD,
      this.dSTAMP,
      this.cCREABY,
      this.cUPDABY,
      this.dCREADT,
      this.dUPDADT});

  GetStartWorkResp.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
    cBRANCD = json['cBRANCD'];
    cBRANNM = json['cBRANNM'];
    cUSRNM = json['cUSRNM'];
    cEMPNM = json['cEMPNM'];
    dINVENTDT = json['dINVENT_DT'];
    cSTATUS = json['cSTATUS'];
    cSECTION = json['cSECTION'];
    cREFCD = json['cREFCD'];
    dSTAMP = json['dSTAMP'];
    cCREABY = json['cCREABY'];
    cUPDABY = json['cUPDABY'];
    dCREADT = json['dCREADT'];
    dUPDADT = json['dUPDADT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    data['cBRANCD'] = this.cBRANCD;
    data['cBRANNM'] = this.cBRANNM;
    data['cUSRNM'] = this.cUSRNM;
    data['cEMPNM'] = this.cEMPNM;
    data['dINVENT_DT'] = this.dINVENTDT;
    data['cSTATUS'] = this.cSTATUS;
    data['cSECTION'] = this.cSECTION;
    data['cREFCD'] = this.cREFCD;
    data['dSTAMP'] = this.dSTAMP;
    data['cCREABY'] = this.cCREABY;
    data['cUPDABY'] = this.cUPDABY;
    data['dCREADT'] = this.dCREADT;
    data['dUPDADT'] = this.dUPDADT;
    return data;
  }
}