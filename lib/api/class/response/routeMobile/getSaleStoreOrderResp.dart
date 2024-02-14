class GetSaleStoreOrderResp {
  String? cGUID;
  String? cCUSTCD;
  String? cCUSTNM;
  String? cCUSTBNM;
  String? cTAXNO;
  String? cTEL;
  String? cCONTACT;
  String? cCONTACTTEL;
  String? cLINEID;
  String? cBRANCD;
  String? cCUSTTYPE;
  String? cPAYTYPE;
  int? iCREDTERM;
  String? iCREDLIM;
  String? cTSELLCD;
  String? cISBASKET;
  String? cSTATUS;
  String? dCREADT;
  String? cCREABY;
  String? dUPDADT;
  String? cUPDABY;
  String? cAUTOPO;
  String? cGRPCD;
  String? cRTECD;
  int? iSEQROUTE;
  String? cISPHOTO;
  String? cPHOTOSERV;
  String? cPHOTOPATH;
  String? cPHOTONM;
  String? cADDRESS;
  String? cSHIPTO;
  String? cLOCATION;
  String? cPROVINCE;
  String? cDISTRICT;
  String? cSUBDIST;
  String? cPOSTCD;
  String? cASSET;
  String? cLATITUDE;
  String? cLONGTITUDE;
  String? cDISTANCS;
  List<String>? cPOCD;

  GetSaleStoreOrderResp(
      {this.cGUID,
      this.cCUSTCD,
      this.cCUSTNM,
      this.cCUSTBNM,
      this.cTAXNO,
      this.cTEL,
      this.cCONTACT,
      this.cCONTACTTEL,
      this.cLINEID,
      this.cBRANCD,
      this.cCUSTTYPE,
      this.cPAYTYPE,
      this.iCREDTERM,
      this.iCREDLIM,
      this.cTSELLCD,
      this.cISBASKET,
      this.cSTATUS,
      this.dCREADT,
      this.cCREABY,
      this.dUPDADT,
      this.cUPDABY,
      this.cAUTOPO,
      this.cGRPCD,
      this.cRTECD,
      this.iSEQROUTE,
      this.cISPHOTO,
      this.cPHOTOSERV,
      this.cPHOTOPATH,
      this.cPHOTONM,
      this.cADDRESS,
      this.cSHIPTO,
      this.cLOCATION,
      this.cPROVINCE,
      this.cDISTRICT,
      this.cSUBDIST,
      this.cPOSTCD,
      this.cASSET,
      this.cLATITUDE,
      this.cLONGTITUDE,
      this.cDISTANCS,
      this.cPOCD});

  GetSaleStoreOrderResp.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
    cCUSTCD = json['cCUSTCD'];
    cCUSTNM = json['cCUSTNM'];
    cCUSTBNM = json['cCUSTBNM'];
    cTAXNO = json['cTAXNO'];
    cTEL = json['cTEL'];
    cCONTACT = json['cCONTACT'];
    cCONTACTTEL = json['cCONTACT_TEL'];
    cLINEID = json['cLINEID'];
    cBRANCD = json['cBRANCD'];
    cCUSTTYPE = json['cCUSTTYPE'];
    cPAYTYPE = json['cPAYTYPE'];
    iCREDTERM = json['iCREDTERM'];
    iCREDLIM = json['iCREDLIM'];
    cTSELLCD = json['cTSELLCD'];
    cISBASKET = json['cISBASKET'];
    cSTATUS = json['cSTATUS'];
    dCREADT = json['dCREADT'];
    cCREABY = json['cCREABY'];
    dUPDADT = json['dUPDADT'];
    cUPDABY = json['cUPDABY'];
    cAUTOPO = json['cAUTOPO'];
    cGRPCD = json['cGRPCD'];
    cRTECD = json['cRTECD'];
    iSEQROUTE = json['iSEQROUTE'];
    cISPHOTO = json['cISPHOTO'];
    cPHOTOSERV = json['cPHOTO_SERV'];
    cPHOTOPATH = json['cPHOTO_PATH'];
    cPHOTONM = json['cPHOTO_NM'];
    cADDRESS = json['cADDRESS'];
    cSHIPTO = json['cSHIPTO'];
    cLOCATION = json['cLOCATION'];
    cPROVINCE = json['cPROVINCE'];
    cDISTRICT = json['cDISTRICT'];
    cSUBDIST = json['cSUBDIST'];
    cPOSTCD = json['cPOSTCD'];
    cASSET = json['cASSET'];
    cLATITUDE = json['cLATITUDE'];
    cLONGTITUDE = json['cLONGTITUDE'];
    cDISTANCS = json['cDISTANCS'];
    cPOCD = json['cPOCD'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    data['cCUSTCD'] = this.cCUSTCD;
    data['cCUSTNM'] = this.cCUSTNM;
    data['cCUSTBNM'] = this.cCUSTBNM;
    data['cTAXNO'] = this.cTAXNO;
    data['cTEL'] = this.cTEL;
    data['cCONTACT'] = this.cCONTACT;
    data['cCONTACT_TEL'] = this.cCONTACTTEL;
    data['cLINEID'] = this.cLINEID;
    data['cBRANCD'] = this.cBRANCD;
    data['cCUSTTYPE'] = this.cCUSTTYPE;
    data['cPAYTYPE'] = this.cPAYTYPE;
    data['iCREDTERM'] = this.iCREDTERM;
    data['iCREDLIM'] = this.iCREDLIM;
    data['cTSELLCD'] = this.cTSELLCD;
    data['cISBASKET'] = this.cISBASKET;
    data['cSTATUS'] = this.cSTATUS;
    data['dCREADT'] = this.dCREADT;
    data['cCREABY'] = this.cCREABY;
    data['dUPDADT'] = this.dUPDADT;
    data['cUPDABY'] = this.cUPDABY;
    data['cAUTOPO'] = this.cAUTOPO;
    data['cGRPCD'] = this.cGRPCD;
    data['cRTECD'] = this.cRTECD;
    data['iSEQROUTE'] = this.iSEQROUTE;
    data['cISPHOTO'] = this.cISPHOTO;
    data['cPHOTO_SERV'] = this.cPHOTOSERV;
    data['cPHOTO_PATH'] = this.cPHOTOPATH;
    data['cPHOTO_NM'] = this.cPHOTONM;
    data['cADDRESS'] = this.cADDRESS;
    data['cSHIPTO'] = this.cSHIPTO;
    data['cLOCATION'] = this.cLOCATION;
    data['cPROVINCE'] = this.cPROVINCE;
    data['cDISTRICT'] = this.cDISTRICT;
    data['cSUBDIST'] = this.cSUBDIST;
    data['cPOSTCD'] = this.cPOSTCD;
    data['cASSET'] = this.cASSET;
    data['cLATITUDE'] = this.cLATITUDE;
    data['cLONGTITUDE'] = this.cLONGTITUDE;
    data['cDISTANCS'] = this.cDISTANCS;
    data['cPOCD'] = this.cPOCD;
    return data;
  }
}
