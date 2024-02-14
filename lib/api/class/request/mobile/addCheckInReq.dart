class AddCheckInReq {
  String? cREFDOC;
  double? iCHELAT;
  double? iCHELNG;
  String? cCHINTYPE;
  String? cCREABY;

  AddCheckInReq(
      {this.cREFDOC, this.iCHELAT, this.iCHELNG, this.cCHINTYPE, this.cCREABY});

  AddCheckInReq.fromJson(Map<String, dynamic> json) {
    cREFDOC = json['cREFDOC'];
    iCHELAT = json['iCHELAT'];
    iCHELNG = json['iCHELNG'];
    cCHINTYPE = json['cCHINTYPE'];
    cCREABY = json['cCREABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cREFDOC'] = this.cREFDOC;
    data['iCHELAT'] = this.iCHELAT;
    data['iCHELNG'] = this.iCHELNG;
    data['cCHINTYPE'] = this.cCHINTYPE;
    data['cCREABY'] = this.cCREABY;
    return data;
  }
}