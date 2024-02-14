class AddReturnProductToStockReq {
  String cBRANCD;
  String cREFDOC;
  int iSEQ;
  String cRETYP;
  String cGRPCD;
  String cRTECD;
  String cPRODCD;
  String cSIZE;
  String cUOMCD;
  String cUOMNM;
  String iUNITPRICE;
  String iQTY;
  String iTRUEQTY;
  String cWH;
  String cCREABY;

  AddReturnProductToStockReq(
      {this.cBRANCD,
      this.cREFDOC,
      this.iSEQ,
      this.cRETYP,
      this.cGRPCD,
      this.cRTECD,
      this.cPRODCD,
      this.cSIZE,
      this.cUOMCD,
      this.cUOMNM,
      this.iUNITPRICE,
      this.iQTY,
      this.iTRUEQTY,
      this.cWH,
      this.cCREABY});

  AddReturnProductToStockReq.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cREFDOC = json['cREF_DOC'];
    iSEQ = json['iSEQ'];
    cRETYP = json['cRETYP'];
    cGRPCD = json['cGRPCD'];
    cRTECD = json['cRTECD'];
    cPRODCD = json['cPRODCD'];
    cSIZE = json['cSIZE'];
    cUOMCD = json['cUOMCD'];
    cUOMNM = json['cUOMNM'];
    iUNITPRICE = json['iUNITPRICE'];
    iQTY = json['iQTY'];
    iTRUEQTY = json['iTRUEQTY'];
    cWH = json['cWH'];
    cCREABY = json['cCREABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['cREF_DOC'] = this.cREFDOC;
    data['iSEQ'] = this.iSEQ;
    data['cRETYP'] = this.cRETYP;
    data['cGRPCD'] = this.cGRPCD;
    data['cRTECD'] = this.cRTECD;
    data['cPRODCD'] = this.cPRODCD;
    data['cSIZE'] = this.cSIZE;
    data['cUOMCD'] = this.cUOMCD;
    data['cUOMNM'] = this.cUOMNM;
    data['iUNITPRICE'] = this.iUNITPRICE;
    data['iQTY'] = this.iQTY;
    data['iTRUEQTY'] = this.iTRUEQTY;
    data['cWH'] = this.cWH;
    data['cCREABY'] = this.cCREABY;
    return data;
  }
}