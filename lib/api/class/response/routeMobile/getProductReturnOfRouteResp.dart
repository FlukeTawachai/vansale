class GetProductReturnOfRouteResp {
  String? cGUID;
  String? cBRANCD;
  String? cRETCD;
  String? cGRPCD;
  String? cRTECD;
  String? cCUSTCD;
  String? cCUSTNM;
  String? cVEHICD;
  String? cDRIVER;
  String? cREMARK;
  String? cCREABY;
  String? cUPDABY;
  String? dCREADT;
  String? dUPDADT;
  String? cPAYST;
  String? iTOTAL;
  String? cREFDOC;
  String? dRETDT;
  String? cRETYP;
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
  String? iSUNITPRICE;
  String? iMUNITPRICE;
  String? iLUNITPRICE;

  GetProductReturnOfRouteResp(
      {this.cGUID,
      this.cBRANCD,
      this.cRETCD,
      this.cGRPCD,
      this.cRTECD,
      this.cCUSTCD,
      this.cCUSTNM,
      this.cVEHICD,
      this.cDRIVER,
      this.cREMARK,
      this.cCREABY,
      this.cUPDABY,
      this.dCREADT,
      this.dUPDADT,
      this.cPAYST,
      this.iTOTAL,
      this.cREFDOC,
      this.dRETDT,
      this.cRETYP,
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
      this.iSUNITPRICE,
      this.iMUNITPRICE,
      this.iLUNITPRICE});

  GetProductReturnOfRouteResp.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
    cBRANCD = json['cBRANCD'];
    cRETCD = json['cRETCD'];
    cGRPCD = json['cGRPCD'];
    cRTECD = json['cRTECD'];
    cCUSTCD = json['cCUSTCD'];
    cCUSTNM = json['cCUSTNM'];
    cVEHICD = json['cVEHICD'];
    cDRIVER = json['cDRIVER'];
    cREMARK = json['cREMARK'];
    cCREABY = json['cCREABY'];
    cUPDABY = json['cUPDABY'];
    dCREADT = json['dCREADT'];
    dUPDADT = json['dUPDADT'];
    cPAYST = json['cPAYST'];
    iTOTAL = json['iTOTAL'];
    cREFDOC = json['cREFDOC'];
    dRETDT = json['dRETDT'];
    cRETYP = json['cRETYP'];
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
    iSUNITPRICE = json['iSUNITPRICE'];
    iMUNITPRICE = json['iMUNITPRICE'];
    iLUNITPRICE = json['iLUNITPRICE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    data['cBRANCD'] = this.cBRANCD;
    data['cRETCD'] = this.cRETCD;
    data['cGRPCD'] = this.cGRPCD;
    data['cRTECD'] = this.cRTECD;
    data['cCUSTCD'] = this.cCUSTCD;
    data['cCUSTNM'] = this.cCUSTNM;
    data['cVEHICD'] = this.cVEHICD;
    data['cDRIVER'] = this.cDRIVER;
    data['cREMARK'] = this.cREMARK;
    data['cCREABY'] = this.cCREABY;
    data['cUPDABY'] = this.cUPDABY;
    data['dCREADT'] = this.dCREADT;
    data['dUPDADT'] = this.dUPDADT;
    data['cPAYST'] = this.cPAYST;
    data['iTOTAL'] = this.iTOTAL;
    data['cREFDOC'] = this.cREFDOC;
    data['dRETDT'] = this.dRETDT;
    data['cRETYP'] = this.cRETYP;
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
    data['iSUNITPRICE'] = this.iSUNITPRICE;
    data['iMUNITPRICE'] = this.iMUNITPRICE;
    data['iLUNITPRICE'] = this.iLUNITPRICE;
    return data;
  }
}
