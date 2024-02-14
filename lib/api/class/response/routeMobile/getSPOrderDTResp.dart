class GetSPOrderDTResp {
  String cGUID;
  String cPOCD;
  int iSEQ;
  String cPRODCD;
  String cPRODNM;
  String iSSTOCK;
  String iMSTOCK;
  String iLSTOCK;
  String cSUOMCD;
  String cSUOMNM;
  String cMUOMCD;
  String cMUOMNM;
  String cLUOMCD;
  String cLUOMNM;
  String iMARKET;
  String iPLUSQTY;
  String iENOUGHQTY;
  String iTOTAL;
  String iPURCHASE;
  String iLUNITPRICE;
  String iNETPRICE;
  String cMONQTY;
  String cTUEQTY;
  String cWEDQTY;
  String cTHUQTY;
  String cFRIQTY;
  String cSATQTY;
  String cSUNQTY;
  String cSTATUS;
  String dCREADT;
  String cCREABY;
  String dUPDADT;
  String cUPDABY;
  String cREFENOUGH;
  String cPHOTOSERV;
  String cPHOTOPATH;
  String cPHOTONM;
  String cBASKCD;
  String cBASKNM;
  String iPRICE;
  String cTYPE;
  String cTYPENM;
  String cCATECD;
  String cCATENM;
  String cSUBCATECD;
  String cSUBCATENM;
  String cBRNDCD;
  String cBRNNM;
  bool cCHECK;

  GetSPOrderDTResp(
      {this.cGUID,
      this.cPOCD,
      this.iSEQ,
      this.cPRODCD,
      this.cPRODNM,
      this.iSSTOCK,
      this.iMSTOCK,
      this.iLSTOCK,
      this.cSUOMCD,
      this.cSUOMNM,
      this.cMUOMCD,
      this.cMUOMNM,
      this.cLUOMCD,
      this.cLUOMNM,
      this.iMARKET,
      this.iPLUSQTY,
      this.iENOUGHQTY,
      this.iTOTAL,
      this.iPURCHASE,
      this.iLUNITPRICE,
      this.iNETPRICE,
      this.cMONQTY,
      this.cTUEQTY,
      this.cWEDQTY,
      this.cTHUQTY,
      this.cFRIQTY,
      this.cSATQTY,
      this.cSUNQTY,
      this.cSTATUS,
      this.dCREADT,
      this.cCREABY,
      this.dUPDADT,
      this.cUPDABY,
      this.cREFENOUGH,
      this.cPHOTOSERV,
      this.cPHOTOPATH,
      this.cPHOTONM,
      this.cBASKCD,
      this.cBASKNM,
      this.iPRICE,
      this.cTYPE,
      this.cTYPENM,
      this.cCATECD,
      this.cCATENM,
      this.cSUBCATECD,
      this.cSUBCATENM,
      this.cBRNDCD,
      this.cBRNNM,
      this.cCHECK});

  GetSPOrderDTResp.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
    cPOCD = json['cPOCD'];
    iSEQ = json['iSEQ'];
    cPRODCD = json['cPRODCD'];
    cPRODNM = json['cPRODNM'];
    iSSTOCK = json['iSSTOCK'];
    iMSTOCK = json['iMSTOCK'];
    iLSTOCK = json['iLSTOCK'];
    cSUOMCD = json['cSUOMCD'];
    cSUOMNM = json['cSUOMNM'];
    cMUOMCD = json['cMUOMCD'];
    cMUOMNM = json['cMUOMNM'];
    cLUOMCD = json['cLUOMCD'];
    cLUOMNM = json['cLUOMNM'];
    iMARKET = json['iMARKET'];
    iPLUSQTY = json['iPLUSQTY'];
    iENOUGHQTY = json['iENOUGHQTY'];
    iTOTAL = json['iTOTAL'];
    iPURCHASE = json['iPURCHASE'];
    iLUNITPRICE = json['iLUNITPRICE'];
    iNETPRICE = json['iNETPRICE'];
    cMONQTY = json['cMONQTY'];
    cTUEQTY = json['cTUEQTY'];
    cWEDQTY = json['cWEDQTY'];
    cTHUQTY = json['cTHUQTY'];
    cFRIQTY = json['cFRIQTY'];
    cSATQTY = json['cSATQTY'];
    cSUNQTY = json['cSUNQTY'];
    cSTATUS = json['cSTATUS'];
    dCREADT = json['dCREADT'];
    cCREABY = json['cCREABY'];
    dUPDADT = json['dUPDADT'];
    cUPDABY = json['cUPDABY'];
    cREFENOUGH = json['cREFENOUGH'];
    cPHOTOSERV = json['cPHOTO_SERV'];
    cPHOTOPATH = json['cPHOTO_PATH'];
    cPHOTONM = json['cPHOTO_NM'];
    cBASKCD = json['cBASKCD'];
    cBASKNM = json['cBASKNM'];
    iPRICE = json['iPRICE'];
    cTYPE = json['cTYPE'];
    cTYPENM = json['cTYPENM'];
    cCATECD = json['cCATECD'];
    cCATENM = json['cCATENM'];
    cSUBCATECD = json['cSUBCATECD'];
    cSUBCATENM = json['cSUBCATENM'];
    cBRNDCD = json['cBRNDCD'];
    cBRNNM = json['cBRNNM'];
    cCHECK = json['cCHECK'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    data['cPOCD'] = this.cPOCD;
    data['iSEQ'] = this.iSEQ;
    data['cPRODCD'] = this.cPRODCD;
    data['cPRODNM'] = this.cPRODNM;
    data['iSSTOCK'] = this.iSSTOCK;
    data['iMSTOCK'] = this.iMSTOCK;
    data['iLSTOCK'] = this.iLSTOCK;
    data['cSUOMCD'] = this.cSUOMCD;
    data['cSUOMNM'] = this.cSUOMNM;
    data['cMUOMCD'] = this.cMUOMCD;
    data['cMUOMNM'] = this.cMUOMNM;
    data['cLUOMCD'] = this.cLUOMCD;
    data['cLUOMNM'] = this.cLUOMNM;
    data['iMARKET'] = this.iMARKET;
    data['iPLUSQTY'] = this.iPLUSQTY;
    data['iENOUGHQTY'] = this.iENOUGHQTY;
    data['iTOTAL'] = this.iTOTAL;
    data['iPURCHASE'] = this.iPURCHASE;
    data['iLUNITPRICE'] = this.iLUNITPRICE;
    data['iNETPRICE'] = this.iNETPRICE;
    data['cMONQTY'] = this.cMONQTY;
    data['cTUEQTY'] = this.cTUEQTY;
    data['cWEDQTY'] = this.cWEDQTY;
    data['cTHUQTY'] = this.cTHUQTY;
    data['cFRIQTY'] = this.cFRIQTY;
    data['cSATQTY'] = this.cSATQTY;
    data['cSUNQTY'] = this.cSUNQTY;
    data['cSTATUS'] = this.cSTATUS;
    data['dCREADT'] = this.dCREADT;
    data['cCREABY'] = this.cCREABY;
    data['dUPDADT'] = this.dUPDADT;
    data['cUPDABY'] = this.cUPDABY;
    data['cREFENOUGH'] = this.cREFENOUGH;
    data['cPHOTO_SERV'] = this.cPHOTOSERV;
    data['cPHOTO_PATH'] = this.cPHOTOPATH;
    data['cPHOTO_NM'] = this.cPHOTONM;
    data['cBASKCD'] = this.cBASKCD;
    data['cBASKNM'] = this.cBASKNM;
    data['iPRICE'] = this.iPRICE;
    data['cTYPE'] = this.cTYPE;
    data['cTYPENM'] = this.cTYPENM;
    data['cCATECD'] = this.cCATECD;
    data['cCATENM'] = this.cCATENM;
    data['cSUBCATECD'] = this.cSUBCATECD;
    data['cSUBCATENM'] = this.cSUBCATENM;
    data['cBRNDCD'] = this.cBRNDCD;
    data['cBRNNM'] = this.cBRNNM;
    data['cCHECK'] = this.cCHECK;
    return data;
  }
}