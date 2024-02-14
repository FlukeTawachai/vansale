class StockBalanceReq {
  String? cBRANCD;
  String? cPRODCD;
  String? cUOMCD;
  String? cWH;
  String? cPRODNM;
  String? cTYPE;
  String? cCATECD;
  String? cSUBCATECD;
  String? cBRNDCD;
  String? iQTY;
  String? iWEIGHT;
  String? cSTATUS;
  String? cCREABY;

  StockBalanceReq(
      {this.cBRANCD,
      this.cPRODCD,
      this.cUOMCD,
      this.cWH,
      this.cPRODNM,
      this.cTYPE,
      this.cCATECD,
      this.cSUBCATECD,
      this.cBRNDCD,
      this.iQTY,
      this.iWEIGHT,
      this.cSTATUS,
      this.cCREABY});

  StockBalanceReq.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cPRODCD = json['cPRODCD'];
    cUOMCD = json['cUOMCD'];
    cWH = json['cWH'];
    cPRODNM = json['cPRODNM'];
    cTYPE = json['cTYPE'];
    cCATECD = json['cCATECD'];
    cSUBCATECD = json['cSUBCATECD'];
    cBRNDCD = json['cBRNDCD'];
    iQTY = json['iQTY'];
    iWEIGHT = json['iWEIGHT'];
    cSTATUS = json['cSTATUS'];
    cCREABY = json['cCREABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['cPRODCD'] = this.cPRODCD;
    data['cUOMCD'] = this.cUOMCD;
    data['cWH'] = this.cWH;
    data['cPRODNM'] = this.cPRODNM;
    data['cTYPE'] = this.cTYPE;
    data['cCATECD'] = this.cCATECD;
    data['cSUBCATECD'] = this.cSUBCATECD;
    data['cBRNDCD'] = this.cBRNDCD;
    data['iQTY'] = this.iQTY;
    data['iWEIGHT'] = this.iWEIGHT;
    data['cSTATUS'] = this.cSTATUS;
    data['cCREABY'] = this.cCREABY;
    return data;
  }
}