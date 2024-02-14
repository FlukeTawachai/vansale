class GetCustomerPODTResp {
  String? cGUID;
  String? cPOCD;
  int? iSEQ;
  String? cPRODCD;
  String? cPRODNM;
  String? cBRNDCD;
  String? cBRNDNM;
  String? iSSIZEQTY;
  String? iMSIZEQTY;
  String? iLSIZEQTY;
  String? cSUOMCD;
  String? cSUOMNM;
  String? cMUOMCD;
  String? cMUOMNM;
  String? cLUOMCD;
  String? cLUOMNM;
  String? cPROMO;
  String? iDISCOUNT;
  String? cDISCOUNT;
  String? iFREE;
  String? iTOTAL;
  String? cBASKCD;
  String? cBASKNM;
  String? cINSERTYPE;
  String? iSUNITPRICE;
  String? iMUNITPRICE;
  String? iLUNITPRICE;
  String? cPREPAIRSTATUS;
  int? iPREPAIRAMOUT;
  String? cSTATUS;
  String? dCREADT;
  String? cCREABY;
  String? dUPDADT;
  String? cUPDABY;
  String? iNETTOTAL;
  int? iINCOMPRO;
  int? iCANCLEPRO;
  int? iLOSSPRO;
  String? cCUSTTYPE;
  String? cISSSIZE;
  String? cISMSIZE;
  String? cISLSIZE;
  String? cTYPE;
  String? iCOST;
  String? iCOSTVAT;
  String? cMCATE;
  String? cSCATE;
  String? cVATTYPE;
  String? iMINSTK;
  String? iMAXSTK;
  String? cSUPCD;
  String? cCOLOR;
  String? cDIMENS;
  String? iWEIGHT;
  String? cSHARE;
  String? cISSALE;
  String? cISBUY;
  String? cISPHOTO;
  String? cPHOTOSERV;
  String? cPHOTOPATH;
  String? cPHOTONM;
  String? iVOLUME;
  String? cCATECD;
  String? cSUBCATECD;

  GetCustomerPODTResp(
      {this.cGUID,
      this.cPOCD,
      this.iSEQ,
      this.cPRODCD,
      this.cPRODNM,
      this.cBRNDCD,
      this.cBRNDNM,
      this.iSSIZEQTY,
      this.iMSIZEQTY,
      this.iLSIZEQTY,
      this.cSUOMCD,
      this.cSUOMNM,
      this.cMUOMCD,
      this.cMUOMNM,
      this.cLUOMCD,
      this.cLUOMNM,
      this.cPROMO,
      this.iDISCOUNT,
      this.cDISCOUNT,
      this.iFREE,
      this.iTOTAL,
      this.cBASKCD,
      this.cBASKNM,
      this.cINSERTYPE,
      this.iSUNITPRICE,
      this.iMUNITPRICE,
      this.iLUNITPRICE,
      this.cPREPAIRSTATUS,
      this.iPREPAIRAMOUT,
      this.cSTATUS,
      this.dCREADT,
      this.cCREABY,
      this.dUPDADT,
      this.cUPDABY,
      this.iNETTOTAL,
      this.iINCOMPRO,
      this.iCANCLEPRO,
      this.iLOSSPRO,
      this.cCUSTTYPE,
      this.cISSSIZE,
      this.cISMSIZE,
      this.cISLSIZE,
      this.cTYPE,
      this.iCOST,
      this.iCOSTVAT,
      this.cMCATE,
      this.cSCATE,
      this.cVATTYPE,
      this.iMINSTK,
      this.iMAXSTK,
      this.cSUPCD,
      this.cCOLOR,
      this.cDIMENS,
      this.iWEIGHT,
      this.cSHARE,
      this.cISSALE,
      this.cISBUY,
      this.cISPHOTO,
      this.cPHOTOSERV,
      this.cPHOTOPATH,
      this.cPHOTONM,
      this.iVOLUME,
      this.cCATECD,
      this.cSUBCATECD});

  GetCustomerPODTResp.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
    cPOCD = json['cPOCD'];
    iSEQ = json['iSEQ'];
    cPRODCD = json['cPRODCD'];
    cPRODNM = json['cPRODNM'];
    cBRNDCD = json['cBRNDCD'];
    cBRNDNM = json['cBRNDNM'];
    iSSIZEQTY = json['iSSIZEQTY'];
    iMSIZEQTY = json['iMSIZEQTY'];
    iLSIZEQTY = json['iLSIZEQTY'];
    cSUOMCD = json['cSUOMCD'];
    cSUOMNM = json['cSUOMNM'];
    cMUOMCD = json['cMUOMCD'];
    cMUOMNM = json['cMUOMNM'];
    cLUOMCD = json['cLUOMCD'];
    cLUOMNM = json['cLUOMNM'];
    cPROMO = json['cPROMO'];
    iDISCOUNT = json['iDISCOUNT'];
    cDISCOUNT = json['cDISCOUNT'];
    iFREE = json['iFREE'];
    iTOTAL = json['iTOTAL'];
    cBASKCD = json['cBASKCD'];
    cBASKNM = json['cBASKNM'];
    cINSERTYPE = json['cINSERTYPE'];
    iSUNITPRICE = json['iSUNITPRICE'];
    iMUNITPRICE = json['iMUNITPRICE'];
    iLUNITPRICE = json['iLUNITPRICE'];
    cPREPAIRSTATUS = json['cPREPAIRSTATUS'];
    iPREPAIRAMOUT = json['iPREPAIRAMOUT'];
    cSTATUS = json['cSTATUS'];
    dCREADT = json['dCREADT'];
    cCREABY = json['cCREABY'];
    dUPDADT = json['dUPDADT'];
    cUPDABY = json['cUPDABY'];
    iNETTOTAL = json['iNETTOTAL'];
    iINCOMPRO = json['iINCOMPRO'];
    iCANCLEPRO = json['iCANCLEPRO'];
    iLOSSPRO = json['iLOSSPRO'];
    cCUSTTYPE = json['cCUSTTYPE'];
    cISSSIZE = json['cISSSIZE'];
    cISMSIZE = json['cISMSIZE'];
    cISLSIZE = json['cISLSIZE'];
    cTYPE = json['cTYPE'];
    iCOST = json['iCOST'];
    iCOSTVAT = json['iCOSTVAT'];
    cMCATE = json['cMCATE'];
    cSCATE = json['cSCATE'];
    cVATTYPE = json['cVATTYPE'];
    iMINSTK = json['iMINSTK'];
    iMAXSTK = json['iMAXSTK'];
    cSUPCD = json['cSUPCD'];
    cCOLOR = json['cCOLOR'];
    cDIMENS = json['cDIMENS'];
    iWEIGHT = json['iWEIGHT'];
    cSHARE = json['cSHARE'];
    cISSALE = json['cISSALE'];
    cISBUY = json['cISBUY'];
    cISPHOTO = json['cISPHOTO'];
    cPHOTOSERV = json['cPHOTO_SERV'];
    cPHOTOPATH = json['cPHOTO_PATH'];
    cPHOTONM = json['cPHOTO_NM'];
    iVOLUME = json['iVOLUME'];
    cCATECD = json['cCATECD'];
    cSUBCATECD = json['cSUBCATECD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    data['cPOCD'] = this.cPOCD;
    data['iSEQ'] = this.iSEQ;
    data['cPRODCD'] = this.cPRODCD;
    data['cPRODNM'] = this.cPRODNM;
    data['cBRNDCD'] = this.cBRNDCD;
    data['cBRNDNM'] = this.cBRNDNM;
    data['iSSIZEQTY'] = this.iSSIZEQTY;
    data['iMSIZEQTY'] = this.iMSIZEQTY;
    data['iLSIZEQTY'] = this.iLSIZEQTY;
    data['cSUOMCD'] = this.cSUOMCD;
    data['cSUOMNM'] = this.cSUOMNM;
    data['cMUOMCD'] = this.cMUOMCD;
    data['cMUOMNM'] = this.cMUOMNM;
    data['cLUOMCD'] = this.cLUOMCD;
    data['cLUOMNM'] = this.cLUOMNM;
    data['cPROMO'] = this.cPROMO;
    data['iDISCOUNT'] = this.iDISCOUNT;
    data['cDISCOUNT'] = this.cDISCOUNT;
    data['iFREE'] = this.iFREE;
    data['iTOTAL'] = this.iTOTAL;
    data['cBASKCD'] = this.cBASKCD;
    data['cBASKNM'] = this.cBASKNM;
    data['cINSERTYPE'] = this.cINSERTYPE;
    data['iSUNITPRICE'] = this.iSUNITPRICE;
    data['iMUNITPRICE'] = this.iMUNITPRICE;
    data['iLUNITPRICE'] = this.iLUNITPRICE;
    data['cPREPAIRSTATUS'] = this.cPREPAIRSTATUS;
    data['iPREPAIRAMOUT'] = this.iPREPAIRAMOUT;
    data['cSTATUS'] = this.cSTATUS;
    data['dCREADT'] = this.dCREADT;
    data['cCREABY'] = this.cCREABY;
    data['dUPDADT'] = this.dUPDADT;
    data['cUPDABY'] = this.cUPDABY;
    data['iNETTOTAL'] = this.iNETTOTAL;
    data['iINCOMPRO'] = this.iINCOMPRO;
    data['iCANCLEPRO'] = this.iCANCLEPRO;
    data['iLOSSPRO'] = this.iLOSSPRO;
    data['cCUSTTYPE'] = this.cCUSTTYPE;
    data['cISSSIZE'] = this.cISSSIZE;
    data['cISMSIZE'] = this.cISMSIZE;
    data['cISLSIZE'] = this.cISLSIZE;
    data['cTYPE'] = this.cTYPE;
    data['iCOST'] = this.iCOST;
    data['iCOSTVAT'] = this.iCOSTVAT;
    data['cMCATE'] = this.cMCATE;
    data['cSCATE'] = this.cSCATE;
    data['cVATTYPE'] = this.cVATTYPE;
    data['iMINSTK'] = this.iMINSTK;
    data['iMAXSTK'] = this.iMAXSTK;
    data['cSUPCD'] = this.cSUPCD;
    data['cCOLOR'] = this.cCOLOR;
    data['cDIMENS'] = this.cDIMENS;
    data['iWEIGHT'] = this.iWEIGHT;
    data['cSHARE'] = this.cSHARE;
    data['cISSALE'] = this.cISSALE;
    data['cISBUY'] = this.cISBUY;
    data['cISPHOTO'] = this.cISPHOTO;
    data['cPHOTO_SERV'] = this.cPHOTOSERV;
    data['cPHOTO_PATH'] = this.cPHOTOPATH;
    data['cPHOTO_NM'] = this.cPHOTONM;
    data['iVOLUME'] = this.iVOLUME;
    data['cCATECD'] = this.cCATECD;
    data['cSUBCATECD'] = this.cSUBCATECD;
    return data;
  }
}
