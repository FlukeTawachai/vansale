class UpdateStroreSortingReq {
  String cCUSTCD;
  String cGRPCD;
  String cRTECD;
  int iSEQROUTE;
  String cUPDABY;

  UpdateStroreSortingReq(
      {this.cCUSTCD, this.cGRPCD, this.cRTECD, this.iSEQROUTE, this.cUPDABY});

  UpdateStroreSortingReq.fromJson(Map<String, dynamic> json) {
    cCUSTCD = json['cCUSTCD'];
    cGRPCD = json['cGRPCD'];
    cRTECD = json['cRTECD'];
    iSEQROUTE = json['iSEQROUTE'];
    cUPDABY = json['cUPDABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cCUSTCD'] = this.cCUSTCD;
    data['cGRPCD'] = this.cGRPCD;
    data['cRTECD'] = this.cRTECD;
    data['iSEQROUTE'] = this.iSEQROUTE;
    data['cUPDABY'] = this.cUPDABY;
    return data;
  }
}