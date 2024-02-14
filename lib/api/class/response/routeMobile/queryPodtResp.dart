class QueryPodtResp {
  String cGUID;
  String cPOCD;
  int iSEQ;
  String cPRODCD;
  String cPRODNM;
  String cTYPE;
  String cTYPENM;
  String cCATECD;
  String cCATENM;
  String cSUBCATECD;
  String cSUBCATENM;
  String cBRNDCD;
  String cBRNDNM;
  String iSSIZEQTY;
  String iMSIZEQTY;
  String iLSIZEQTY;
  String cSUOMNM;
  String cMUOMNM;
  String cLUOMNM;
  String cPROMO;
  String iDISCOUNT;
  String cDISCOUNT;
  String iFREE;
  String iTOTAL;
  String cBASKCD;
  String cBASKNM;
  String cSTATUS;
  String dCREADT;
  String cCREABY;
  String dUPDADT;
  String cUPDABY;
  String cINSERTYPE;
  String iSUNITPRICE;
  String iMUNITPRICE;
  String iLUNITPRICE;
  String cPREPAIRSTATUS;
  String iPREPAIRAMOUT;
  String cPHOTOSERV;
  String cPHOTOPATH;
  String iNETTOTAL;
  int iINCOMPRO;
  int iCANCLEPRO;
  int iLOSSPRO;
  String cSUOMCD;
  String cMUOMCD;
  String cLUOMCD;
  String cISSSIZE;
  String cISMSIZE;
  String cISLSIZE;

  QueryPodtResp(
      {this.cGUID,
      this.cPOCD,
      this.iSEQ,
      this.cPRODCD,
      this.cPRODNM,
      this.cTYPE,
      this.cTYPENM,
      this.cCATECD,
      this.cCATENM,
      this.cSUBCATECD,
      this.cSUBCATENM,
      this.cBRNDCD,
      this.cBRNDNM,
      this.iSSIZEQTY,
      this.iMSIZEQTY,
      this.iLSIZEQTY,
      this.cSUOMNM,
      this.cMUOMNM,
      this.cLUOMNM,
      this.cPROMO,
      this.iDISCOUNT,
      this.cDISCOUNT,
      this.iFREE,
      this.iTOTAL,
      this.cBASKCD,
      this.cBASKNM,
      this.cSTATUS,
      this.dCREADT,
      this.cCREABY,
      this.dUPDADT,
      this.cUPDABY,
      this.cINSERTYPE,
      this.iSUNITPRICE,
      this.iMUNITPRICE,
      this.iLUNITPRICE,
      this.cPREPAIRSTATUS,
      this.iPREPAIRAMOUT,
      this.cPHOTOSERV,
      this.cPHOTOPATH,
      this.iNETTOTAL,
      this.iINCOMPRO,
      this.iCANCLEPRO,
      this.iLOSSPRO,
      this.cSUOMCD,
      this.cMUOMCD,
      this.cLUOMCD,
      this.cISSSIZE,
      this.cISMSIZE,
      this.cISLSIZE});

  QueryPodtResp.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
    cPOCD = json['cPOCD'];
    iSEQ = json['iSEQ'];
    cPRODCD = json['cPRODCD'];
    cPRODNM = json['cPRODNM'];
    cTYPE = json['cTYPE'];
    cTYPENM = json['cTYPENM'];
    cCATECD = json['cCATECD'];
    cCATENM = json['cCATENM'];
    cSUBCATECD = json['cSUBCATECD'];
    cSUBCATENM = json['cSUBCATENM'];
    cBRNDCD = json['cBRNDCD'];
    cBRNDNM = json['cBRNDNM'];
    iSSIZEQTY = json['iSSIZEQTY'];
    iMSIZEQTY = json['iMSIZEQTY'];
    iLSIZEQTY = json['iLSIZEQTY'];
    cSUOMNM = json['cSUOMNM'];
    cMUOMNM = json['cMUOMNM'];
    cLUOMNM = json['cLUOMNM'];
    cPROMO = json['cPROMO'];
    iDISCOUNT = json['iDISCOUNT'];
    cDISCOUNT = json['cDISCOUNT'];
    iFREE = json['iFREE'];
    iTOTAL = json['iTOTAL'];
    cBASKCD = json['cBASKCD'];
    cBASKNM = json['cBASKNM'];
    cSTATUS = json['cSTATUS'];
    dCREADT = json['dCREADT'];
    cCREABY = json['cCREABY'];
    dUPDADT = json['dUPDADT'];
    cUPDABY = json['cUPDABY'];
    cINSERTYPE = json['cINSERTYPE'];
    iSUNITPRICE = json['iSUNITPRICE'];
    iMUNITPRICE = json['iMUNITPRICE'];
    iLUNITPRICE = json['iLUNITPRICE'];
    cPREPAIRSTATUS = json['cPREPAIRSTATUS'];
    iPREPAIRAMOUT = json['iPREPAIRAMOUT'];
    cPHOTOSERV = json['cPHOTO_SERV'];
    cPHOTOPATH = json['cPHOTO_PATH'];
    iNETTOTAL = json['iNETTOTAL'];
    iINCOMPRO = json['iINCOMPRO'];
    iCANCLEPRO = json['iCANCLEPRO'];
    iLOSSPRO = json['iLOSSPRO'];
    cSUOMCD = json['cSUOMCD'];
    cMUOMCD = json['cMUOMCD'];
    cLUOMCD = json['cLUOMCD'];
    cISSSIZE = json['cISSSIZE'];
    cISMSIZE = json['cISMSIZE'];
    cISLSIZE = json['cISLSIZE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    data['cPOCD'] = this.cPOCD;
    data['iSEQ'] = this.iSEQ;
    data['cPRODCD'] = this.cPRODCD;
    data['cPRODNM'] = this.cPRODNM;
    data['cTYPE'] = this.cTYPE;
    data['cTYPENM'] = this.cTYPENM;
    data['cCATECD'] = this.cCATECD;
    data['cCATENM'] = this.cCATENM;
    data['cSUBCATECD'] = this.cSUBCATECD;
    data['cSUBCATENM'] = this.cSUBCATENM;
    data['cBRNDCD'] = this.cBRNDCD;
    data['cBRNDNM'] = this.cBRNDNM;
    data['iSSIZEQTY'] = this.iSSIZEQTY;
    data['iMSIZEQTY'] = this.iMSIZEQTY;
    data['iLSIZEQTY'] = this.iLSIZEQTY;
    data['cSUOMNM'] = this.cSUOMNM;
    data['cMUOMNM'] = this.cMUOMNM;
    data['cLUOMNM'] = this.cLUOMNM;
    data['cPROMO'] = this.cPROMO;
    data['iDISCOUNT'] = this.iDISCOUNT;
    data['cDISCOUNT'] = this.cDISCOUNT;
    data['iFREE'] = this.iFREE;
    data['iTOTAL'] = this.iTOTAL;
    data['cBASKCD'] = this.cBASKCD;
    data['cBASKNM'] = this.cBASKNM;
    data['cSTATUS'] = this.cSTATUS;
    data['dCREADT'] = this.dCREADT;
    data['cCREABY'] = this.cCREABY;
    data['dUPDADT'] = this.dUPDADT;
    data['cUPDABY'] = this.cUPDABY;
    data['cINSERTYPE'] = this.cINSERTYPE;
    data['iSUNITPRICE'] = this.iSUNITPRICE;
    data['iMUNITPRICE'] = this.iMUNITPRICE;
    data['iLUNITPRICE'] = this.iLUNITPRICE;
    data['cPREPAIRSTATUS'] = this.cPREPAIRSTATUS;
    data['iPREPAIRAMOUT'] = this.iPREPAIRAMOUT;
    data['cPHOTO_SERV'] = this.cPHOTOSERV;
    data['cPHOTO_PATH'] = this.cPHOTOPATH;
    data['iNETTOTAL'] = this.iNETTOTAL;
    data['iINCOMPRO'] = this.iINCOMPRO;
    data['iCANCLEPRO'] = this.iCANCLEPRO;
    data['iLOSSPRO'] = this.iLOSSPRO;
    data['cSUOMCD'] = this.cSUOMCD;
    data['cMUOMCD'] = this.cMUOMCD;
    data['cLUOMCD'] = this.cLUOMCD;
    data['cISSSIZE'] = this.cISSSIZE;
    data['cISMSIZE'] = this.cISMSIZE;
    data['cISLSIZE'] = this.cISLSIZE;
    return data;
  }
}