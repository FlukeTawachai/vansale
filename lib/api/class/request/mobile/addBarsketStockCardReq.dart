class AddBasketStockCardReq {
  String? cBRANCD;
  String? cWH;
  String? cBASKCD;
  String? cBASKNM;
  String? cUOMCD;
  String? cREFDOC;
  String? iRECEIVEQTY;
  String? iISSUEQTY;
  String? cREMARK;
  String? cCREABY;

  AddBasketStockCardReq(
      {this.cBRANCD,
      this.cWH,
      this.cBASKCD,
      this.cBASKNM,
      this.cUOMCD,
      this.cREFDOC,
      this.iRECEIVEQTY,
      this.iISSUEQTY,
      this.cREMARK,
      this.cCREABY});

  AddBasketStockCardReq.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cWH = json['cWH'];
    cBASKCD = json['cBASKCD'];
    cBASKNM = json['cBASKNM'];
    cUOMCD = json['cUOMCD'];
    cREFDOC = json['cREFDOC'];
    iRECEIVEQTY = json['iRECEIVE_QTY'];
    iISSUEQTY = json['iISSUE_QTY'];
    cREMARK = json['cREMARK'];
    cCREABY = json['cCREABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['cWH'] = this.cWH;
    data['cBASKCD'] = this.cBASKCD;
    data['cBASKNM'] = this.cBASKNM;
    data['cUOMCD'] = this.cUOMCD;
    data['cREFDOC'] = this.cREFDOC;
    data['iRECEIVE_QTY'] = this.iRECEIVEQTY;
    data['iISSUE_QTY'] = this.iISSUEQTY;
    data['cREMARK'] = this.cREMARK;
    data['cCREABY'] = this.cCREABY;
    return data;
  }
}