class GetProductSetResp {
  String? cGUID;
  String? cSETCD;
  String? cSETNM;
  String? cBRANCD;
  String? cBRANNM;
  String? cCUSTTYPE;
  String? iSSIZEQTY;
  String? iMSIZEQTY;
  String? iLSIZEQTY;
  String? cSTATUS;
  String? cCREABY;
  String? cUPDABY;
  String? dCREADT;
  String? dUPDADT;
  List<APRODUCTGetProductSet>? aPRODUCT;

  GetProductSetResp(
      {this.cGUID,
      this.cSETCD,
      this.cSETNM,
      this.cBRANCD,
      this.cBRANNM,
      this.cCUSTTYPE,
      this.iSSIZEQTY,
      this.iMSIZEQTY,
      this.iLSIZEQTY,
      this.cSTATUS,
      this.cCREABY,
      this.cUPDABY,
      this.dCREADT,
      this.dUPDADT,
      this.aPRODUCT});

  GetProductSetResp.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
    cSETCD = json['cSETCD'];
    cSETNM = json['cSETNM'];
    cBRANCD = json['cBRANCD'];
    cBRANNM = json['cBRANNM'];
    cCUSTTYPE = json['cCUSTTYPE'];
    iSSIZEQTY = json['iSSIZEQTY'];
    iMSIZEQTY = json['iMSIZEQTY'];
    iLSIZEQTY = json['iLSIZEQTY'];
    cSTATUS = json['cSTATUS'];
    cCREABY = json['cCREABY'];
    cUPDABY = json['cUPDABY'];
    dCREADT = json['dCREADT'];
    dUPDADT = json['dUPDADT'];
    if (json['aPRODUCT'] != null) {
      aPRODUCT = <APRODUCTGetProductSet>[];
      json['aPRODUCT'].forEach((v) {
        aPRODUCT?.add(new APRODUCTGetProductSet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    data['cSETCD'] = this.cSETCD;
    data['cSETNM'] = this.cSETNM;
    data['cBRANCD'] = this.cBRANCD;
    data['cBRANNM'] = this.cBRANNM;
    data['cCUSTTYPE'] = this.cCUSTTYPE;
    data['iSSIZEQTY'] = this.iSSIZEQTY;
    data['iMSIZEQTY'] = this.iMSIZEQTY;
    data['iLSIZEQTY'] = this.iLSIZEQTY;
    data['cSTATUS'] = this.cSTATUS;
    data['cCREABY'] = this.cCREABY;
    data['cUPDABY'] = this.cUPDABY;
    data['dCREADT'] = this.dCREADT;
    data['dUPDADT'] = this.dUPDADT;
    if (this.aPRODUCT != null) {
      data['aPRODUCT'] = this.aPRODUCT?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class APRODUCTGetProductSet {
  String? cGUID;
  String? cSETCD;
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
  String? iSUOMQTY;
  String? cMUOMCD;
  String? cMUOMNM;
  String? iMUOMQTY;
  String? cLUOMCD;
  String? cLUOMNM;
  String? iLUOMQTY;
  String? cBASKCD;
  String? cBASKNM;
  String? dCREADT;
  String? cCREABY;
  String? dUPDADT;
  String? cUPDABY;
  String? iCOST;
  String? iCOSTVAT;
  String? cPRODEX;
  String? iGENVAT;
  String? iEXCVAT;
  String? cTYPE;
  String? cMCATE;
  String? cSCATE;
  String? cCOLOR;
  String? cDIMENS;
  String? iWEIGHT;
  String? cSUPCD;
  String? cSHARE;
  String? iMINSTK;
  String? iMAXSTK;
  String? iSUomPrice;
  String? iMUomPrice;
  String? iLUomPrice;

  APRODUCTGetProductSet(
      {this.cGUID,
      this.cSETCD,
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
      this.iSUOMQTY,
      this.cMUOMCD,
      this.cMUOMNM,
      this.iMUOMQTY,
      this.cLUOMCD,
      this.cLUOMNM,
      this.iLUOMQTY,
      this.cBASKCD,
      this.cBASKNM,
      this.dCREADT,
      this.cCREABY,
      this.dUPDADT,
      this.cUPDABY,
      this.iCOST,
      this.iCOSTVAT,
      this.cPRODEX,
      this.iGENVAT,
      this.iEXCVAT,
      this.cTYPE,
      this.cMCATE,
      this.cSCATE,
      this.cCOLOR,
      this.cDIMENS,
      this.iWEIGHT,
      this.cSUPCD,
      this.cSHARE,
      this.iMINSTK,
      this.iMAXSTK,
      this.iSUomPrice,
      this.iMUomPrice,
      this.iLUomPrice});

  APRODUCTGetProductSet.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
    cSETCD = json['cSETCD'];
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
    iSUOMQTY = json['iSUOMQTY'];
    cMUOMCD = json['cMUOMCD'];
    cMUOMNM = json['cMUOMNM'];
    iMUOMQTY = json['iMUOMQTY'];
    cLUOMCD = json['cLUOMCD'];
    cLUOMNM = json['cLUOMNM'];
    iLUOMQTY = json['iLUOMQTY'];
    cBASKCD = json['cBASKCD'];
    cBASKNM = json['cBASKNM'];
    dCREADT = json['dCREADT'];
    cCREABY = json['cCREABY'];
    dUPDADT = json['dUPDADT'];
    cUPDABY = json['cUPDABY'];
    iCOST = json['iCOST'];
    iCOSTVAT = json['iCOSTVAT'];
    cPRODEX = json['cPRODEX'];
    iGENVAT = json['iGENVAT'];
    iEXCVAT = json['iEXCVAT'];
    cTYPE = json['cTYPE'];
    cMCATE = json['cMCATE'];
    cSCATE = json['cSCATE'];
    cCOLOR = json['cCOLOR'];
    cDIMENS = json['cDIMENS'];
    iWEIGHT = json['iWEIGHT'];
    cSUPCD = json['cSUPCD'];
    cSHARE = json['cSHARE'];
    iMINSTK = json['iMINSTK'];
    iMAXSTK = json['iMAXSTK'];
    iSUomPrice = json['iSUomPrice'];
    iMUomPrice = json['iMUomPrice'];
    iLUomPrice = json['iLUomPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    data['cSETCD'] = this.cSETCD;
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
    data['iSUOMQTY'] = this.iSUOMQTY;
    data['cMUOMCD'] = this.cMUOMCD;
    data['cMUOMNM'] = this.cMUOMNM;
    data['iMUOMQTY'] = this.iMUOMQTY;
    data['cLUOMCD'] = this.cLUOMCD;
    data['cLUOMNM'] = this.cLUOMNM;
    data['iLUOMQTY'] = this.iLUOMQTY;
    data['cBASKCD'] = this.cBASKCD;
    data['cBASKNM'] = this.cBASKNM;
    data['dCREADT'] = this.dCREADT;
    data['cCREABY'] = this.cCREABY;
    data['dUPDADT'] = this.dUPDADT;
    data['cUPDABY'] = this.cUPDABY;
    data['iCOST'] = this.iCOST;
    data['iCOSTVAT'] = this.iCOSTVAT;
    data['cPRODEX'] = this.cPRODEX;
    data['iGENVAT'] = this.iGENVAT;
    data['iEXCVAT'] = this.iEXCVAT;
    data['cTYPE'] = this.cTYPE;
    data['cMCATE'] = this.cMCATE;
    data['cSCATE'] = this.cSCATE;
    data['cCOLOR'] = this.cCOLOR;
    data['cDIMENS'] = this.cDIMENS;
    data['iWEIGHT'] = this.iWEIGHT;
    data['cSUPCD'] = this.cSUPCD;
    data['cSHARE'] = this.cSHARE;
    data['iMINSTK'] = this.iMINSTK;
    data['iMAXSTK'] = this.iMAXSTK;
    data['iSUomPrice'] = this.iSUomPrice;
    data['iMUomPrice'] = this.iMUomPrice;
    data['iLUomPrice'] = this.iLUomPrice;
    return data;
  }
}
