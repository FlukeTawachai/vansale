class AddSupplierReceiveDTReq {
  String? cRECEIVENO;
  String? iSEQ;
  String? cPRODCD;
  String? cPRODNM;
  String? cBRNDCD;
  String? cBRNDNM;
  String? cSUOMCD;
  String? cSUOMNM;
  String? cMUOMCD;
  String? cMUOMNM;
  String? cLUOMCD;
  String? cLUOMNM;
  String? iSORDERQTY;
  String? iMORDERQTY;
  String? iLORDERQTY;
  String? iPLUSQTY;
  String? iLOSSQTY;
  String? cREMARK;
  String? cCREABY;

  AddSupplierReceiveDTReq(
      {this.cRECEIVENO,
      this.iSEQ,
      this.cPRODCD,
      this.cPRODNM,
      this.cBRNDCD,
      this.cBRNDNM,
      this.cSUOMCD,
      this.cSUOMNM,
      this.cMUOMCD,
      this.cMUOMNM,
      this.cLUOMCD,
      this.cLUOMNM,
      this.iSORDERQTY,
      this.iMORDERQTY,
      this.iLORDERQTY,
      this.iPLUSQTY,
      this.iLOSSQTY,
      this.cREMARK,
      this.cCREABY});

  AddSupplierReceiveDTReq.fromJson(Map<String, dynamic> json) {
    cRECEIVENO = json['cRECEIVE_NO'];
    iSEQ = json['iSEQ'];
    cPRODCD = json['cPRODCD'];
    cPRODNM = json['cPRODNM'];
    cBRNDCD = json['cBRNDCD'];
    cBRNDNM = json['cBRNDNM'];
    cSUOMCD = json['cSUOMCD'];
    cSUOMNM = json['cSUOMNM'];
    cMUOMCD = json['cMUOMCD'];
    cMUOMNM = json['cMUOMNM'];
    cLUOMCD = json['cLUOMCD'];
    cLUOMNM = json['cLUOMNM'];
    iSORDERQTY = json['iSORDERQTY'];
    iMORDERQTY = json['iMORDERQTY'];
    iLORDERQTY = json['iLORDERQTY'];
    iPLUSQTY = json['iPLUSQTY'];
    iLOSSQTY = json['iLOSSQTY'];
    cREMARK = json['cREMARK'];
    cCREABY = json['cCREABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cRECEIVE_NO'] = this.cRECEIVENO;
    data['iSEQ'] = this.iSEQ;
    data['cPRODCD'] = this.cPRODCD;
    data['cPRODNM'] = this.cPRODNM;
    data['cBRNDCD'] = this.cBRNDCD;
    data['cBRNDNM'] = this.cBRNDNM;
    data['cSUOMCD'] = this.cSUOMCD;
    data['cSUOMNM'] = this.cSUOMNM;
    data['cMUOMCD'] = this.cMUOMCD;
    data['cMUOMNM'] = this.cMUOMNM;
    data['cLUOMCD'] = this.cLUOMCD;
    data['cLUOMNM'] = this.cLUOMNM;
    data['iSORDERQTY'] = this.iSORDERQTY;
    data['iMORDERQTY'] = this.iMORDERQTY;
    data['iLORDERQTY'] = this.iLORDERQTY;
    data['iPLUSQTY'] = this.iPLUSQTY;
    data['iLOSSQTY'] = this.iLOSSQTY;
    data['cREMARK'] = this.cREMARK;
    data['cCREABY'] = this.cCREABY;
    return data;
  }
}