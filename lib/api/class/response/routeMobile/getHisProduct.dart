class GetHisProductResp {
  String? cPRODCD;
  String? cPRODNM;
  String? cTYPE;
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
  String? cTYPENM;
  String? cCATECD;
  String? cCATENM;
  String? cSUBCATECD;
  String? cSUBCATENM;
  String? cBRNDCD;
  String? cBRNDNM;
  String? cPHOTOSERV;
  String? cPHOTOPATH;
  String? cPHOTONM;
  int? iINCOMPRO;
  int? iCANCLEPRO;
  int? iLOSSPRO;
  String? cSTATUS;

  GetHisProductResp(
      {this.cPRODCD,
      this.cPRODNM,
      this.cTYPE,
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
      this.cTYPENM,
      this.cCATECD,
      this.cCATENM,
      this.cSUBCATECD,
      this.cSUBCATENM,
      this.cBRNDCD,
      this.cBRNDNM,
      this.cPHOTOSERV,
      this.cPHOTOPATH,
      this.cPHOTONM,
      this.iINCOMPRO,
      this.iCANCLEPRO,
      this.iLOSSPRO,
      this.cSTATUS});

  GetHisProductResp.fromJson(Map<String, dynamic> json) {
    cPRODCD = json['cPRODCD'];
    cPRODNM = json['cPRODNM'];
    cTYPE = json['cTYPE'];
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
    cTYPENM = json['cTYPENM'];
    cCATECD = json['cCATECD'];
    cCATENM = json['cCATENM'];
    cSUBCATECD = json['cSUBCATECD'];
    cSUBCATENM = json['cSUBCATENM'];
    cBRNDCD = json['cBRNDCD'];
    cBRNDNM = json['cBRNDNM'];
    cPHOTOSERV = json['cPHOTO_SERV'];
    cPHOTOPATH = json['cPHOTO_PATH'];
    cPHOTONM = json['cPHOTO_NM'];
    iINCOMPRO = json['iINCOMPRO'];
    iCANCLEPRO = json['iCANCLEPRO'];
    iLOSSPRO = json['iLOSSPRO'];
    cSTATUS = json['cSTATUS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cPRODCD'] = this.cPRODCD;
    data['cPRODNM'] = this.cPRODNM;
    data['cTYPE'] = this.cTYPE;
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
    data['cTYPENM'] = this.cTYPENM;
    data['cCATECD'] = this.cCATECD;
    data['cCATENM'] = this.cCATENM;
    data['cSUBCATECD'] = this.cSUBCATECD;
    data['cSUBCATENM'] = this.cSUBCATENM;
    data['cBRNDCD'] = this.cBRNDCD;
    data['cBRNDNM'] = this.cBRNDNM;
    data['cPHOTO_SERV'] = this.cPHOTOSERV;
    data['cPHOTO_PATH'] = this.cPHOTOPATH;
    data['cPHOTO_NM'] = this.cPHOTONM;
    data['iINCOMPRO'] = this.iINCOMPRO;
    data['iCANCLEPRO'] = this.iCANCLEPRO;
    data['iLOSSPRO'] = this.iLOSSPRO;
    data['cSTATUS'] = this.cSTATUS;
    return data;
  }
}
