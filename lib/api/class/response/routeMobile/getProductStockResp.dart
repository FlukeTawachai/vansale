class GetProductStockResp {
  String? cGUID;
  String? cBRANCD;
  String? cWH;
  String? cPRODCD;
  String? cUOMCD;
  String? cPRODNM;
  String? cTYPE;
  String? cCATECD;
  String? cSUBCATECD;
  String? cBRNDCD;
  String? iQTY;
  String? iWEIGHT;
  String? cSTATUS;
  String? dCREADT;
  String? cCREABY;
  String? dUPDADT;
  String? cUPDABY;

  GetProductStockResp(
      {this.cGUID,
      this.cBRANCD,
      this.cWH,
      this.cPRODCD,
      this.cUOMCD,
      this.cPRODNM,
      this.cTYPE,
      this.cCATECD,
      this.cSUBCATECD,
      this.cBRNDCD,
      this.iQTY,
      this.iWEIGHT,
      this.cSTATUS,
      this.dCREADT,
      this.cCREABY,
      this.dUPDADT,
      this.cUPDABY});

  GetProductStockResp.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
    cBRANCD = json['cBRANCD'];
    cWH = json['cWH'];
    cPRODCD = json['cPRODCD'];
    cUOMCD = json['cUOMCD'];
    cPRODNM = json['cPRODNM'];
    cTYPE = json['cTYPE'];
    cCATECD = json['cCATECD'];
    cSUBCATECD = json['cSUBCATECD'];
    cBRNDCD = json['cBRNDCD'];
    iQTY = json['iQTY'];
    iWEIGHT = json['iWEIGHT'];
    cSTATUS = json['cSTATUS'];
    dCREADT = json['dCREADT'];
    cCREABY = json['cCREABY'];
    dUPDADT = json['dUPDADT'];
    cUPDABY = json['cUPDABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    data['cBRANCD'] = this.cBRANCD;
    data['cWH'] = this.cWH;
    data['cPRODCD'] = this.cPRODCD;
    data['cUOMCD'] = this.cUOMCD;
    data['cPRODNM'] = this.cPRODNM;
    data['cTYPE'] = this.cTYPE;
    data['cCATECD'] = this.cCATECD;
    data['cSUBCATECD'] = this.cSUBCATECD;
    data['cBRNDCD'] = this.cBRNDCD;
    data['iQTY'] = this.iQTY;
    data['iWEIGHT'] = this.iWEIGHT;
    data['cSTATUS'] = this.cSTATUS;
    data['dCREADT'] = this.dCREADT;
    data['cCREABY'] = this.cCREABY;
    data['dUPDADT'] = this.dUPDADT;
    data['cUPDABY'] = this.cUPDABY;
    return data;
  }
}
