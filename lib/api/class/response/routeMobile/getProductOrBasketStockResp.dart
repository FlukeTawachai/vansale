class GetProductOrBasketStockResp {
  String cBRANCD;
  String cWH;
  String cPRODCD;
  String cUOMCD;
  String cPRODNM;
  String cTYPE;
  String cCATECD;
  String cSUBCATECD;
  String cBRNDCD;
  String iPROQTY;
  String iWEIGHT;
  String cSTATUS;
  String cBASKCD;
  String cBASKNM;
  String iBKQTY;

  GetProductOrBasketStockResp(
      {this.cBRANCD,
      this.cWH,
      this.cPRODCD,
      this.cUOMCD,
      this.cPRODNM,
      this.cTYPE,
      this.cCATECD,
      this.cSUBCATECD,
      this.cBRNDCD,
      this.iPROQTY,
      this.iWEIGHT,
      this.cSTATUS,
      this.cBASKCD,
      this.cBASKNM,
      this.iBKQTY});

  GetProductOrBasketStockResp.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cWH = json['cWH'];
    cPRODCD = json['cPRODCD'];
    cUOMCD = json['cUOMCD'];
    cPRODNM = json['cPRODNM'];
    cTYPE = json['cTYPE'];
    cCATECD = json['cCATECD'];
    cSUBCATECD = json['cSUBCATECD'];
    cBRNDCD = json['cBRNDCD'];
    iPROQTY = json['iPROQTY'];
    iWEIGHT = json['iWEIGHT'];
    cSTATUS = json['cSTATUS'];
    cBASKCD = json['cBASKCD'];
    cBASKNM = json['cBASKNM'];
    iBKQTY = json['iBKQTY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['cWH'] = this.cWH;
    data['cPRODCD'] = this.cPRODCD;
    data['cUOMCD'] = this.cUOMCD;
    data['cPRODNM'] = this.cPRODNM;
    data['cTYPE'] = this.cTYPE;
    data['cCATECD'] = this.cCATECD;
    data['cSUBCATECD'] = this.cSUBCATECD;
    data['cBRNDCD'] = this.cBRNDCD;
    data['iPROQTY'] = this.iPROQTY;
    data['iWEIGHT'] = this.iWEIGHT;
    data['cSTATUS'] = this.cSTATUS;
    data['cBASKCD'] = this.cBASKCD;
    data['cBASKNM'] = this.cBASKNM;
    data['iBKQTY'] = this.iBKQTY;
    return data;
  }
}