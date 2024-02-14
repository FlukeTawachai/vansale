class UserDataResp {
  String cGUID;
  String cUSRNM;
  String cEMPNM;
  String cPASSWRD;
  String cPHOTOSERV;
  String cPHOTOPATH;
  String cISPHOTO;
  String cBRANCD;
  String cPOSNM;
  String cPMSCD;
  String cSTATUS;
  String dCREADT;
  String cCREABY;
  String dUPDADT;
  String cUPDABY;

  UserDataResp(
      {this.cGUID,
      this.cUSRNM,
      this.cEMPNM,
      this.cPASSWRD,
      this.cPHOTOSERV,
      this.cPHOTOPATH,
      this.cISPHOTO,
      this.cBRANCD,
      this.cPOSNM,
      this.cPMSCD,
      this.cSTATUS,
      this.dCREADT,
      this.cCREABY,
      this.dUPDADT,
      this.cUPDABY});

  UserDataResp.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
    cUSRNM = json['cUSRNM'];
    cEMPNM = json['cEMPNM'];
    cPASSWRD = json['cPASSWRD'];
    cPHOTOSERV = json['cPHOTO_SERV'];
    cPHOTOPATH = json['cPHOTO_PATH'];
    cISPHOTO = json['cISPHOTO'];
    cBRANCD = json['cBRANCD'];
    cPOSNM = json['cPOSNM'];
    cPMSCD = json['cPMSCD'];
    cSTATUS = json['cSTATUS'];
    dCREADT = json['dCREADT'];
    cCREABY = json['cCREABY'];
    dUPDADT = json['dUPDADT'];
    cUPDABY = json['cUPDABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    data['cUSRNM'] = this.cUSRNM;
    data['cEMPNM'] = this.cEMPNM;
    data['cPASSWRD'] = this.cPASSWRD;
    data['cPHOTO_SERV'] = this.cPHOTOSERV;
    data['cPHOTO_PATH'] = this.cPHOTOPATH;
    data['cISPHOTO'] = this.cISPHOTO;
    data['cBRANCD'] = this.cBRANCD;
    data['cPOSNM'] = this.cPOSNM;
    data['cPMSCD'] = this.cPMSCD;
    data['cSTATUS'] = this.cSTATUS;
    data['dCREADT'] = this.dCREADT;
    data['cCREABY'] = this.cCREABY;
    data['dUPDADT'] = this.dUPDADT;
    data['cUPDABY'] = this.cUPDABY;
    return data;
  }
}