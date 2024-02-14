class GetCustHisWithDateReq {
  String cCUSTCD;
  String dSHIPDATE;

  GetCustHisWithDateReq({this.cCUSTCD, this.dSHIPDATE});

  GetCustHisWithDateReq.fromJson(Map<String, dynamic> json) {
    cCUSTCD = json['cCUSTCD'];
    dSHIPDATE = json['dSHIPDATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cCUSTCD'] = this.cCUSTCD;
    data['dSHIPDATE'] = this.dSHIPDATE;
    return data;
  }
}