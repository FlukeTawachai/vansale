class GetProductOfSupplierResp {
  String cGUID;
  String cPRODCD;
  String cPRODNM;
  String cTYPE;
  String iCOST;
  String iCOSTVAT;
  String cMCATE;
  String cSCATE;
  String cVATTYPE;
  String iMINSTK;
  String iMAXSTK;
  String cBRNDCD;
  String cBASKCD;
  String cSUPCD;
  String cCOLOR;
  String cDIMENS;
  String iWEIGHT;
  String cSHARE;
  String cISSALE;
  String cISBUY;
  String cISPHOTO;
  String cPHOTOSERV;
  String cPHOTOPATH;
  String cPHOTONM;
  String cSTATUS;
  String dCREADT;
  String cCREABY;
  String dUPDADT;
  String cUPDABY;
  String iVOLUME;
  String cCATECD;
  String cSUBCATECD;

  GetProductOfSupplierResp(
      {this.cGUID,
      this.cPRODCD,
      this.cPRODNM,
      this.cTYPE,
      this.iCOST,
      this.iCOSTVAT,
      this.cMCATE,
      this.cSCATE,
      this.cVATTYPE,
      this.iMINSTK,
      this.iMAXSTK,
      this.cBRNDCD,
      this.cBASKCD,
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
      this.cSTATUS,
      this.dCREADT,
      this.cCREABY,
      this.dUPDADT,
      this.cUPDABY,
      this.iVOLUME,
      this.cCATECD,
      this.cSUBCATECD});

  GetProductOfSupplierResp.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
    cPRODCD = json['cPRODCD'];
    cPRODNM = json['cPRODNM'];
    cTYPE = json['cTYPE'];
    iCOST = json['iCOST'];
    iCOSTVAT = json['iCOSTVAT'];
    cMCATE = json['cMCATE'];
    cSCATE = json['cSCATE'];
    cVATTYPE = json['cVATTYPE'];
    iMINSTK = json['iMINSTK'];
    iMAXSTK = json['iMAXSTK'];
    cBRNDCD = json['cBRNDCD'];
    cBASKCD = json['cBASKCD'];
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
    cSTATUS = json['cSTATUS'];
    dCREADT = json['dCREADT'];
    cCREABY = json['cCREABY'];
    dUPDADT = json['dUPDADT'];
    cUPDABY = json['cUPDABY'];
    iVOLUME = json['iVOLUME'];
    cCATECD = json['cCATECD'];
    cSUBCATECD = json['cSUBCATECD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    data['cPRODCD'] = this.cPRODCD;
    data['cPRODNM'] = this.cPRODNM;
    data['cTYPE'] = this.cTYPE;
    data['iCOST'] = this.iCOST;
    data['iCOSTVAT'] = this.iCOSTVAT;
    data['cMCATE'] = this.cMCATE;
    data['cSCATE'] = this.cSCATE;
    data['cVATTYPE'] = this.cVATTYPE;
    data['iMINSTK'] = this.iMINSTK;
    data['iMAXSTK'] = this.iMAXSTK;
    data['cBRNDCD'] = this.cBRNDCD;
    data['cBASKCD'] = this.cBASKCD;
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
    data['cSTATUS'] = this.cSTATUS;
    data['dCREADT'] = this.dCREADT;
    data['cCREABY'] = this.cCREABY;
    data['dUPDADT'] = this.dUPDADT;
    data['cUPDABY'] = this.cUPDABY;
    data['iVOLUME'] = this.iVOLUME;
    data['cCATECD'] = this.cCATECD;
    data['cSUBCATECD'] = this.cSUBCATECD;
    return data;
  }
}