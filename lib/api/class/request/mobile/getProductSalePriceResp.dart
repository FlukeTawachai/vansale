class GetProductSalePriceResp {
  String cGUID;
  String cPRODCD;
  String cPRODNM;
  String iCOST;
  String iCOSTVAT;
  String cPRODEX;
  String iGENVAT;
  String iEXCVAT;
  String cTYPE;
  String cMCATE;
  String cSCATE;
  String cBRNDCD;
  String cCOLOR;
  String cDIMENS;
  String iWEIGHT;
  String cBASKCD;
  String cSUPCD;
  String cSHARE;
  String iMINSTK;
  String iMAXSTK;
  String dCREADT;
  String cCREABY;
  String dUPDADT;
  String cUPDABY;
  List<TPRICEDT> tPRICEDT;

  GetProductSalePriceResp(
      {this.cGUID,
      this.cPRODCD,
      this.cPRODNM,
      this.iCOST,
      this.iCOSTVAT,
      this.cPRODEX,
      this.iGENVAT,
      this.iEXCVAT,
      this.cTYPE,
      this.cMCATE,
      this.cSCATE,
      this.cBRNDCD,
      this.cCOLOR,
      this.cDIMENS,
      this.iWEIGHT,
      this.cBASKCD,
      this.cSUPCD,
      this.cSHARE,
      this.iMINSTK,
      this.iMAXSTK,
      this.dCREADT,
      this.cCREABY,
      this.dUPDADT,
      this.cUPDABY,
      this.tPRICEDT});

  GetProductSalePriceResp.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
    cPRODCD = json['cPRODCD'];
    cPRODNM = json['cPRODNM'];
    iCOST = json['iCOST'];
    iCOSTVAT = json['iCOSTVAT'];
    cPRODEX = json['cPRODEX'];
    iGENVAT = json['iGENVAT'];
    iEXCVAT = json['iEXCVAT'];
    cTYPE = json['cTYPE'];
    cMCATE = json['cMCATE'];
    cSCATE = json['cSCATE'];
    cBRNDCD = json['cBRNDCD'];
    cCOLOR = json['cCOLOR'];
    cDIMENS = json['cDIMENS'];
    iWEIGHT = json['iWEIGHT'];
    cBASKCD = json['cBASKCD'];
    cSUPCD = json['cSUPCD'];
    cSHARE = json['cSHARE'];
    iMINSTK = json['iMINSTK'];
    iMAXSTK = json['iMAXSTK'];
    dCREADT = json['dCREADT'];
    cCREABY = json['cCREABY'];
    dUPDADT = json['dUPDADT'];
    cUPDABY = json['cUPDABY'];
    if (json['tPRICEDT'] != null) {
      tPRICEDT = <TPRICEDT>[];
      json['tPRICEDT'].forEach((v) {
        tPRICEDT.add(new TPRICEDT.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    data['cPRODCD'] = this.cPRODCD;
    data['cPRODNM'] = this.cPRODNM;
    data['iCOST'] = this.iCOST;
    data['iCOSTVAT'] = this.iCOSTVAT;
    data['cPRODEX'] = this.cPRODEX;
    data['iGENVAT'] = this.iGENVAT;
    data['iEXCVAT'] = this.iEXCVAT;
    data['cTYPE'] = this.cTYPE;
    data['cMCATE'] = this.cMCATE;
    data['cSCATE'] = this.cSCATE;
    data['cBRNDCD'] = this.cBRNDCD;
    data['cCOLOR'] = this.cCOLOR;
    data['cDIMENS'] = this.cDIMENS;
    data['iWEIGHT'] = this.iWEIGHT;
    data['cBASKCD'] = this.cBASKCD;
    data['cSUPCD'] = this.cSUPCD;
    data['cSHARE'] = this.cSHARE;
    data['iMINSTK'] = this.iMINSTK;
    data['iMAXSTK'] = this.iMAXSTK;
    data['dCREADT'] = this.dCREADT;
    data['cCREABY'] = this.cCREABY;
    data['dUPDADT'] = this.dUPDADT;
    data['cUPDABY'] = this.cUPDABY;
    if (this.tPRICEDT != null) {
      data['tPRICEDT'] = this.tPRICEDT.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TPRICEDT {
  String cGUID;
  String cPRODCD;
  String cUOMCD;
  String cPRICECD;
  int iSEQ;
  String cTYPE;
  String iCOST;
  String iQTY;
  String cBARCODE;
  String cUOMNM;
  String cTABLENM;
  String dCREADT;
  String cCREABY;
  String dUPDADT;
  String cUPDABY;

  TPRICEDT(
      {this.cGUID,
      this.cPRODCD,
      this.cUOMCD,
      this.cPRICECD,
      this.iSEQ,
      this.cTYPE,
      this.iCOST,
      this.iQTY,
      this.cBARCODE,
      this.cUOMNM,
      this.cTABLENM,
      this.dCREADT,
      this.cCREABY,
      this.dUPDADT,
      this.cUPDABY});

  TPRICEDT.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
    cPRODCD = json['cPRODCD'];
    cUOMCD = json['cUOMCD'];
    cPRICECD = json['cPRICECD'];
    iSEQ = json['iSEQ'];
    cTYPE = json['cTYPE'];
    iCOST = json['iCOST'];
    iQTY = json['iQTY'];
    cBARCODE = json['cBARCODE'];
    cUOMNM = json['cUOMNM'];
    cTABLENM = json['cTABLENM'];
    dCREADT = json['dCREADT'];
    cCREABY = json['cCREABY'];
    dUPDADT = json['dUPDADT'];
    cUPDABY = json['cUPDABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    data['cPRODCD'] = this.cPRODCD;
    data['cUOMCD'] = this.cUOMCD;
    data['cPRICECD'] = this.cPRICECD;
    data['iSEQ'] = this.iSEQ;
    data['cTYPE'] = this.cTYPE;
    data['iCOST'] = this.iCOST;
    data['iQTY'] = this.iQTY;
    data['cBARCODE'] = this.cBARCODE;
    data['cUOMNM'] = this.cUOMNM;
    data['cTABLENM'] = this.cTABLENM;
    data['dCREADT'] = this.dCREADT;
    data['cCREABY'] = this.cCREABY;
    data['dUPDADT'] = this.dUPDADT;
    data['cUPDABY'] = this.cUPDABY;
    return data;
  }
}