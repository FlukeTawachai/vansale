class UpdateICLProReq {
  String cPOCD;
  int iSEQ;
  int iINCOMPRO;
  int iCANCLEPRO;
  int iLOSSPRO;
  String cUPDABY;

  UpdateICLProReq(
      {this.cPOCD,
      this.iSEQ,
      this.iINCOMPRO,
      this.iCANCLEPRO,
      this.iLOSSPRO,
      this.cUPDABY});

  UpdateICLProReq.fromJson(Map<String, dynamic> json) {
    cPOCD = json['cPOCD'];
    iSEQ = json['iSEQ'];
    iINCOMPRO = json['iINCOMPRO'];
    iCANCLEPRO = json['iCANCLEPRO'];
    iLOSSPRO = json['iLOSSPRO'];
    cUPDABY = json['cUPDABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cPOCD'] = this.cPOCD;
    data['iSEQ'] = this.iSEQ;
    data['iINCOMPRO'] = this.iINCOMPRO;
    data['iCANCLEPRO'] = this.iCANCLEPRO;
    data['iLOSSPRO'] = this.iLOSSPRO;
    data['cUPDABY'] = this.cUPDABY;
    return data;
  }
}