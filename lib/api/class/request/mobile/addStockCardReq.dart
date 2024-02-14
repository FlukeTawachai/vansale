class StockCardReq {
  String? cBRANCD;
  String? cPRODCD;
  String? cUOMCD;
  String? cWH;
  String? cREFDOC;
  String? iRECEIVEQTY;
  String? iISSUEQTY;
  String? cREMARK;
  String? cLOTNO;
  String? cCREABY;

  StockCardReq(
      {this.cBRANCD,
      this.cPRODCD,
      this.cUOMCD,
      this.cWH,
      this.cREFDOC,
      this.iRECEIVEQTY,
      this.iISSUEQTY,
      this.cREMARK,
      this.cLOTNO,
      this.cCREABY});

  StockCardReq.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cPRODCD = json['cPRODCD'];
    cUOMCD = json['cUOMCD'];
    cWH = json['cWH'];
    cREFDOC = json['cREF_DOC'];
    iRECEIVEQTY = json['iRECEIVE_QTY'];
    iISSUEQTY = json['iISSUE_QTY'];
    cREMARK = json['cREMARK'];
    cLOTNO = json['cLOT_NO'];
    cCREABY = json['cCREABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['cPRODCD'] = this.cPRODCD;
    data['cUOMCD'] = this.cUOMCD;
    data['cWH'] = this.cWH;
    data['cREF_DOC'] = this.cREFDOC;
    data['iRECEIVE_QTY'] = this.iRECEIVEQTY;
    data['iISSUE_QTY'] = this.iISSUEQTY;
    data['cREMARK'] = this.cREMARK;
    data['cLOT_NO'] = this.cLOTNO;
    data['cCREABY'] = this.cCREABY;
    return data;
  }
}