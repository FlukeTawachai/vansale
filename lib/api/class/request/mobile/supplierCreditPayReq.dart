class SupplierCreditPayReq {
  String cSUPPCD;
  String cBRANCD;
  String cPRODCD;
  String cCREABY;

  SupplierCreditPayReq(
      {this.cSUPPCD, this.cBRANCD, this.cPRODCD, this.cCREABY});

  SupplierCreditPayReq.fromJson(Map<String, dynamic> json) {
    cSUPPCD = json['cSUPPCD'];
    cBRANCD = json['cBRANCD'];
    cPRODCD = json['cPRODCD'];
    cCREABY = json['cCREABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cSUPPCD'] = this.cSUPPCD;
    data['cBRANCD'] = this.cBRANCD;
    data['cPRODCD'] = this.cPRODCD;
    data['cCREABY'] = this.cCREABY;
    return data;
  }
}