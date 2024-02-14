class AddSupplierReceivBillReq {
  String? cRECEIVENO;
  String? iSEQ;
  String? cSERVER;
  String? cIB64;
  String? cREFDOC;
  String? cTYPE;
  String? cCREABY;

  AddSupplierReceivBillReq(
      {this.cRECEIVENO,
      this.iSEQ,
      this.cSERVER,
      this.cIB64,
      this.cREFDOC,
      this.cTYPE,
      this.cCREABY});

  AddSupplierReceivBillReq.fromJson(Map<String, dynamic> json) {
    cRECEIVENO = json['cRECEIVE_NO'];
    iSEQ = json['iSEQ'];
    cSERVER = json['cSERVER'];
    cIB64 = json['cIB64'];
    cREFDOC = json['cREF_DOC'];
    cTYPE = json['cTYPE'];
    cCREABY = json['cCREABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cRECEIVE_NO'] = this.cRECEIVENO;
    data['iSEQ'] = this.iSEQ;
    data['cSERVER'] = this.cSERVER;
    data['cIB64'] = this.cIB64;
    data['cREF_DOC'] = this.cREFDOC;
    data['cTYPE'] = this.cTYPE;
    data['cCREABY'] = this.cCREABY;
    return data;
  }
}