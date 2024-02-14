class GetCustomerGroupResp {
  String cGUID;
  String cCUSTCD;
  String cGRPCD;
  String cRTECD;
  String dCREADT;
  String cCREABY;
  String dUPDADT;
  String cUPDABY;
  int iSEQROUTE;

  GetCustomerGroupResp(
      {this.cGUID,
      this.cCUSTCD,
      this.cGRPCD,
      this.cRTECD,
      this.dCREADT,
      this.cCREABY,
      this.dUPDADT,
      this.cUPDABY,
      this.iSEQROUTE});

  GetCustomerGroupResp.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
    cCUSTCD = json['cCUSTCD'];
    cGRPCD = json['cGRPCD'];
    cRTECD = json['cRTECD'];
    dCREADT = json['dCREADT'];
    cCREABY = json['cCREABY'];
    dUPDADT = json['dUPDADT'];
    cUPDABY = json['cUPDABY'];
    iSEQROUTE = json['iSEQROUTE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    data['cCUSTCD'] = this.cCUSTCD;
    data['cGRPCD'] = this.cGRPCD;
    data['cRTECD'] = this.cRTECD;
    data['dCREADT'] = this.dCREADT;
    data['cCREABY'] = this.cCREABY;
    data['dUPDADT'] = this.dUPDADT;
    data['cUPDABY'] = this.cUPDABY;
    data['iSEQROUTE'] = this.iSEQROUTE == null ? 1 : this.iSEQROUTE;
    return data;
  }
}