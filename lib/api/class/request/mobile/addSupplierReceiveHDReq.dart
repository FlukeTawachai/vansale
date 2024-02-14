class AddSupplierReceiveHDReq {
  String? cREFDOC;
  String? cRECEIVEBY;
  String? iBEFOREVAT;
  String? iVATVAL;
  String? iSKIPVAT;
  String? iTOTAL;
  String? cREMARK;
  String? cCREABY;

  AddSupplierReceiveHDReq(
      {this.cREFDOC,
      this.cRECEIVEBY,
      this.iBEFOREVAT,
      this.iVATVAL,
      this.iSKIPVAT,
      this.iTOTAL,
      this.cREMARK,
      this.cCREABY});

  AddSupplierReceiveHDReq.fromJson(Map<String, dynamic> json) {
    cREFDOC = json['cREF_DOC'];
    cRECEIVEBY = json['cRECEIVE_BY'];
    iBEFOREVAT = json['iBEFORE_VAT'];
    iVATVAL = json['iVAT_VAL'];
    iSKIPVAT = json['iSKIP_VAT'];
    iTOTAL = json['iTOTAL'];
    cREMARK = json['cREMARK'];
    cCREABY = json['cCREABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cREF_DOC'] = this.cREFDOC;
    data['cRECEIVE_BY'] = this.cRECEIVEBY;
    data['iBEFORE_VAT'] = this.iBEFOREVAT;
    data['iVAT_VAL'] = this.iVATVAL;
    data['iSKIP_VAT'] = this.iSKIPVAT;
    data['iTOTAL'] = this.iTOTAL;
    data['cREMARK'] = this.cREMARK;
    data['cCREABY'] = this.cCREABY;
    return data;
  }
}