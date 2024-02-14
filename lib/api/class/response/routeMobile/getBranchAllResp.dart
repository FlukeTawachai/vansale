class GetBranchAllResp {
  String cGUID;
  String cBRANCD;
  String cBRANNM;
  String cSHOPNM;
  String cTAXNO;
  String cADDRESS;
  String cPROVINCE;
  String cDISTRICT;
  String cSUBDIST;
  String cPOSTCD;
  String cBRANTEL;
  String cBRANFAX;
  String cCONTNM;
  String cCONTTEL;
  String cLOCATION;
  String cISPHOTO;
  String cPHOTOSERV;
  String cPHOTOPATH;
  String cPHOTONM;
  String cSTATUS;
  String dCREADT;
  String cCREABY;
  String dUPDADT;
  String cUPDABY;
  String cBRANABB;

  GetBranchAllResp(
      {this.cGUID,
      this.cBRANCD,
      this.cBRANNM,
      this.cSHOPNM,
      this.cTAXNO,
      this.cADDRESS,
      this.cPROVINCE,
      this.cDISTRICT,
      this.cSUBDIST,
      this.cPOSTCD,
      this.cBRANTEL,
      this.cBRANFAX,
      this.cCONTNM,
      this.cCONTTEL,
      this.cLOCATION,
      this.cISPHOTO,
      this.cPHOTOSERV,
      this.cPHOTOPATH,
      this.cPHOTONM,
      this.cSTATUS,
      this.dCREADT,
      this.cCREABY,
      this.dUPDADT,
      this.cUPDABY,
      this.cBRANABB});

  GetBranchAllResp.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
    cBRANCD = json['cBRANCD'];
    cBRANNM = json['cBRANNM'];
    cSHOPNM = json['cSHOPNM'];
    cTAXNO = json['cTAXNO'];
    cADDRESS = json['cADDRESS'];
    cPROVINCE = json['cPROVINCE'];
    cDISTRICT = json['cDISTRICT'];
    cSUBDIST = json['cSUBDIST'];
    cPOSTCD = json['cPOSTCD'];
    cBRANTEL = json['cBRANTEL'];
    cBRANFAX = json['cBRANFAX'];
    cCONTNM = json['cCONTNM'];
    cCONTTEL = json['cCONTTEL'];
    cLOCATION = json['cLOCATION'];
    cISPHOTO = json['cISPHOTO'];
    cPHOTOSERV = json['cPHOTO_SERV'];
    cPHOTOPATH = json['cPHOTO_PATH'];
    cPHOTONM = json['cPHOTO_NM'];
    cSTATUS = json['cSTATUS'];
    dCREADT = json['dCREADT'];
    cCREABY = json['cCREABY'];
    dUPDADT = json['dUPDADT'];
    cUPDABY = json['cUPDABY'];
    cBRANABB = json['cBRANABB'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    data['cBRANCD'] = this.cBRANCD;
    data['cBRANNM'] = this.cBRANNM;
    data['cSHOPNM'] = this.cSHOPNM;
    data['cTAXNO'] = this.cTAXNO;
    data['cADDRESS'] = this.cADDRESS;
    data['cPROVINCE'] = this.cPROVINCE;
    data['cDISTRICT'] = this.cDISTRICT;
    data['cSUBDIST'] = this.cSUBDIST;
    data['cPOSTCD'] = this.cPOSTCD;
    data['cBRANTEL'] = this.cBRANTEL;
    data['cBRANFAX'] = this.cBRANFAX;
    data['cCONTNM'] = this.cCONTNM;
    data['cCONTTEL'] = this.cCONTTEL;
    data['cLOCATION'] = this.cLOCATION;
    data['cISPHOTO'] = this.cISPHOTO;
    data['cPHOTO_SERV'] = this.cPHOTOSERV;
    data['cPHOTO_PATH'] = this.cPHOTOPATH;
    data['cPHOTO_NM'] = this.cPHOTONM;
    data['cSTATUS'] = this.cSTATUS;
    data['dCREADT'] = this.dCREADT;
    data['cCREABY'] = this.cCREABY;
    data['dUPDADT'] = this.dUPDADT;
    data['cUPDABY'] = this.cUPDABY;
    data['cBRANABB'] = this.cBRANABB;
    return data;
  }
}