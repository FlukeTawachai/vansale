class AddRecheckStockProductReq {
  String cBRANCD;
  String cWH;
  String cPRODCD;
  String cUOMCD;
  String cPRODNM;
  String cTYPE;
  String cCATECD;
  String cSUBCATECD;
  String cBRNDCD;
  double iSTCQTY;
  double iSTCWEIGHT;
  double iRECQTY;
  double iRECWEIGHT;
  String cSALETYPE;
  String cCREABY;

  AddRecheckStockProductReq(
      {this.cBRANCD,
      this.cWH,
      this.cPRODCD,
      this.cUOMCD,
      this.cPRODNM,
      this.cTYPE,
      this.cCATECD,
      this.cSUBCATECD,
      this.cBRNDCD,
      this.iSTCQTY,
      this.iSTCWEIGHT,
      this.iRECQTY,
      this.iRECWEIGHT,
      this.cSALETYPE,
      this.cCREABY});

  AddRecheckStockProductReq.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cWH = json['cWH'];
    cPRODCD = json['cPRODCD'];
    cUOMCD = json['cUOMCD'];
    cPRODNM = json['cPRODNM'];
    cTYPE = json['cTYPE'];
    cCATECD = json['cCATECD'];
    cSUBCATECD = json['cSUBCATECD'];
    cBRNDCD = json['cBRNDCD'];
    iSTCQTY = json['iSTCQTY'];
    iSTCWEIGHT = json['iSTCWEIGHT'];
    iRECQTY = json['iRECQTY'];
    iRECWEIGHT = json['iRECWEIGHT'];
    cSALETYPE = json['cSALETYPE'];
    cCREABY = json['cCREABY'];
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
    data['iSTCQTY'] = this.iSTCQTY;
    data['iSTCWEIGHT'] = this.iSTCWEIGHT;
    data['iRECQTY'] = this.iRECQTY;
    data['iRECWEIGHT'] = this.iRECWEIGHT;
    data['cSALETYPE'] = this.cSALETYPE;
    data['cCREABY'] = this.cCREABY;
    return data;
  }
}