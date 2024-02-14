class AddReturnBasketToStockReq {
  String? cBRANCD;
  String? cREFDOC;
  int? iSEQ;
  String? cGRPCD;
  String? cRTECD;
  String? cBASKCD;
  String? iPRICE;
  String? iQTY;
  String? iTRUEQTY;
  String? cWH;
  String? cCREABY;

  AddReturnBasketToStockReq(
      {this.cBRANCD,
      this.cREFDOC,
      this.iSEQ,
      this.cGRPCD,
      this.cRTECD,
      this.cBASKCD,
      this.iPRICE,
      this.iQTY,
      this.iTRUEQTY,
      this.cWH,
      this.cCREABY});

  AddReturnBasketToStockReq.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cREFDOC = json['cREF_DOC'];
    iSEQ = json['iSEQ'];
    cGRPCD = json['cGRPCD'];
    cRTECD = json['cRTECD'];
    cBASKCD = json['cBASKCD'];
    iPRICE = json['iPRICE'];
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
    data['cGRPCD'] = this.cGRPCD;
    data['cRTECD'] = this.cRTECD;
    data['cBASKCD'] = this.cBASKCD;
    data['iPRICE'] = this.iPRICE;
    data['iQTY'] = this.iQTY;
    data['iTRUEQTY'] = this.iTRUEQTY;
    data['cWH'] = this.cWH;
    data['cCREABY'] = this.cCREABY;
    return data;
  }
}