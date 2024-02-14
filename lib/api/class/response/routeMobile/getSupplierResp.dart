class GetSupplierResp {
  String? cGUID;
  String? cSUPCD;
  String? cSUPNM;
  String? cBRANNM;
  String? cSUPTAXID;
  String? cTEL;
  String? cPAYTYPE;
  String? cCONTACT;
  String? cCONTTEL;
  String? cLINE;
  String? cBASKFEE;
  int? iDCREDIT;
  String? iMCREDIT;
  String? iBASPRICE;
  String? iVAL;
  String? cPHOTOSERV;
  String? cPHOTOPATH;
  String? cISPHOTO;
  String? cSTATUS;
  String? dCREADT;
  String? cCREABY;
  String? dUPDADT;
  String? cUPDABY;
  String? cPHOTONM;
  String? cTRANSDEF;

  GetSupplierResp(
      {this.cGUID,
      this.cSUPCD,
      this.cSUPNM,
      this.cBRANNM,
      this.cSUPTAXID,
      this.cTEL,
      this.cPAYTYPE,
      this.cCONTACT,
      this.cCONTTEL,
      this.cLINE,
      this.cBASKFEE,
      this.iDCREDIT,
      this.iMCREDIT,
      this.iBASPRICE,
      this.iVAL,
      this.cPHOTOSERV,
      this.cPHOTOPATH,
      this.cISPHOTO,
      this.cSTATUS,
      this.dCREADT,
      this.cCREABY,
      this.dUPDADT,
      this.cUPDABY,
      this.cPHOTONM,
      this.cTRANSDEF});

  GetSupplierResp.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
    cSUPCD = json['cSUPCD'];
    cSUPNM = json['cSUPNM'];
    cBRANNM = json['cBRANNM'];
    cSUPTAXID = json['cSUPTAXID'];
    cTEL = json['cTEL'];
    cPAYTYPE = json['cPAYTYPE'];
    cCONTACT = json['cCONTACT'];
    cCONTTEL = json['cCONTTEL'];
    cLINE = json['cLINE'];
    cBASKFEE = json['cBASKFEE'];
    iDCREDIT = json['iDCREDIT'];
    iMCREDIT = json['iMCREDIT'];
    iBASPRICE = json['iBASPRICE'];
    iVAL = json['iVAL'];
    cPHOTOSERV = json['cPHOTO_SERV'];
    cPHOTOPATH = json['cPHOTO_PATH'];
    cISPHOTO = json['cISPHOTO'];
    cSTATUS = json['cSTATUS'];
    dCREADT = json['dCREADT'];
    cCREABY = json['cCREABY'];
    dUPDADT = json['dUPDADT'];
    cUPDABY = json['cUPDABY'];
    cPHOTONM = json['cPHOTO_NM'];
    cTRANSDEF = json['cTRANS_DEF'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    data['cSUPCD'] = this.cSUPCD;
    data['cSUPNM'] = this.cSUPNM;
    data['cBRANNM'] = this.cBRANNM;
    data['cSUPTAXID'] = this.cSUPTAXID;
    data['cTEL'] = this.cTEL;
    data['cPAYTYPE'] = this.cPAYTYPE;
    data['cCONTACT'] = this.cCONTACT;
    data['cCONTTEL'] = this.cCONTTEL;
    data['cLINE'] = this.cLINE;
    data['cBASKFEE'] = this.cBASKFEE;
    data['iDCREDIT'] = this.iDCREDIT;
    data['iMCREDIT'] = this.iMCREDIT;
    data['iBASPRICE'] = this.iBASPRICE;
    data['iVAL'] = this.iVAL;
    data['cPHOTO_SERV'] = this.cPHOTOSERV;
    data['cPHOTO_PATH'] = this.cPHOTOPATH;
    data['cISPHOTO'] = this.cISPHOTO;
    data['cSTATUS'] = this.cSTATUS;
    data['dCREADT'] = this.dCREADT;
    data['cCREABY'] = this.cCREABY;
    data['dUPDADT'] = this.dUPDADT;
    data['cUPDABY'] = this.cUPDABY;
    data['cPHOTO_NM'] = this.cPHOTONM;
    data['cTRANS_DEF'] = this.cTRANSDEF;
    return data;
  }
}
