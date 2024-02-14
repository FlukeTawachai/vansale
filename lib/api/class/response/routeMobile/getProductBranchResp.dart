class GetProductBranchResp {
  String? cPRODCD;
  String? cPRODNM;
  String? cTYPE;
  String? cTYPENM;
  String? cCATECD;
  String? cCATENM;
  String? cSUBCATECD;
  String? cSUBCATENM;
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
  String? iSUNITPRICE;
  String? iMUNITPRICE;
  String? iLUNITPRICE;
  String? cCUSTTYPE;
  String? cISSSIZE;
  String? cISMSIZE;
  String? cISLSIZE;
  String? cPHOTOSERV;
  String? cPHOTOPATH;
  String? cPHOTONM;
  String? cSUPCD;
  String? cRETCD;
  bool? cCHECK;
  bool? cICUL;
  bool? cDCUL;

  GetProductBranchResp(
      {this.cPRODCD,
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
      this.cSUOMCD,
      this.cSUOMNM,
      this.cMUOMCD,
      this.cMUOMNM,
      this.cLUOMCD,
      this.cLUOMNM,
      this.iSUNITPRICE,
      this.iMUNITPRICE,
      this.iLUNITPRICE,
      this.cCUSTTYPE,
      this.cISSSIZE,
      this.cISMSIZE,
      this.cISLSIZE,
      this.cPHOTOSERV,
      this.cPHOTOPATH,
      this.cPHOTONM,
      this.cSUPCD,
      this.cRETCD,
      this.cCHECK,
      this.cICUL,
      this.cDCUL});

  GetProductBranchResp.fromJson(Map<String, dynamic> json) {
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
    cSUOMCD = json['cSUOMCD'];
    cSUOMNM = json['cSUOMNM'];
    cMUOMCD = json['cMUOMCD'];
    cMUOMNM = json['cMUOMNM'];
    cLUOMCD = json['cLUOMCD'];
    cLUOMNM = json['cLUOMNM'];
    iSUNITPRICE = json['iSUNITPRICE'];
    iMUNITPRICE = json['iMUNITPRICE'];
    iLUNITPRICE = json['iLUNITPRICE'];
    cCUSTTYPE = json['cCUSTTYPE'];
    cISSSIZE = json['cISSSIZE'];
    cISMSIZE = json['cISMSIZE'];
    cISLSIZE = json['cISLSIZE'];
    cPHOTOSERV = json['cPHOTO_SERV'];
    cPHOTOPATH = json['cPHOTO_PATH'];
    cPHOTONM = json['cPHOTO_NM'];
    cSUPCD = json['cSUPCD'];
    cRETCD = json['cRETCD'];
    cCHECK = json['cCHECK'];
    cICUL = json['cICUL'];
    cDCUL = json['cDCUL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['cSUOMCD'] = this.cSUOMCD;
    data['cSUOMNM'] = this.cSUOMNM;
    data['cMUOMCD'] = this.cMUOMCD;
    data['cMUOMNM'] = this.cMUOMNM;
    data['cLUOMCD'] = this.cLUOMCD;
    data['cLUOMNM'] = this.cLUOMNM;
    data['iSUNITPRICE'] = this.iSUNITPRICE;
    data['iMUNITPRICE'] = this.iMUNITPRICE;
    data['iLUNITPRICE'] = this.iLUNITPRICE;
    data['cCUSTTYPE'] = this.cCUSTTYPE;
    data['cISSSIZE'] = this.cISSSIZE;
    data['cISMSIZE'] = this.cISMSIZE;
    data['cISLSIZE'] = this.cISLSIZE;
    data['cPHOTO_SERV'] = this.cPHOTOSERV;
    data['cPHOTO_PATH'] = this.cPHOTOPATH;
    data['cPHOTO_NM'] = this.cPHOTONM;
    data['cSUPCD'] = this.cSUPCD;
    data['cRETCD'] = this.cRETCD;
    data['cCHECK'] = this.cCHECK;
    data['cICUL'] = this.cICUL;
    data['cDCUL'] = this.cDCUL;
    return data;
  }
}
