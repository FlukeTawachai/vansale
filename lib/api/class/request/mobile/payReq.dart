class PayReq {
  String? cDOCREF;
  String? dDOCDATE;
  String? cTRANSCD;
  String? cCONTACTCD;
  double? iDEBIT;
  double? iCREDIT;
  String? cCREABY;
  String? cRECTYPE;
  String? cBANK;
  String? cCQTYPE;
  String? cCQCD;
  String? cCQDT;

  PayReq(
      {this.cDOCREF,
      this.dDOCDATE,
      this.cTRANSCD,
      this.cCONTACTCD,
      this.iDEBIT,
      this.iCREDIT,
      this.cCREABY,
      this.cRECTYPE,
      this.cBANK,
      this.cCQTYPE,
      this.cCQCD,
      this.cCQDT});

  PayReq.fromJson(Map<String, dynamic> json) {
    cDOCREF = json['cDOCREF'];
    dDOCDATE = json['dDOCDATE'];
    cTRANSCD = json['cTRANSCD'];
    cCONTACTCD = json['cCONTACTCD'];
    iDEBIT = json['iDEBIT'];
    iCREDIT = json['iCREDIT'];
    cCREABY = json['cCREABY'];
    cRECTYPE = json['cRECTYPE'];
    cBANK = json['cBANK'];
    cCQTYPE = json['cCQTYPE'];
    cCQCD = json['cCQCD'];
    cCQDT = json['cCQDT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cDOCREF'] = this.cDOCREF;
    data['dDOCDATE'] = this.dDOCDATE;
    data['cTRANSCD'] = this.cTRANSCD;
    data['cCONTACTCD'] = this.cCONTACTCD;
    data['iDEBIT'] = this.iDEBIT;
    data['iCREDIT'] = this.iCREDIT;
    data['cCREABY'] = this.cCREABY;
    data['cRECTYPE'] = this.cRECTYPE;
    data['cBANK'] = this.cBANK;
    data['cCQTYPE'] = this.cCQTYPE;
    data['cCQCD'] = this.cCQCD;
    data['cCQDT'] = this.cCQDT;
    return data;
  }
}
