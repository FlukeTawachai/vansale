class GetHisBasketResp {
  String cBASKCD;
  String cBASKNM;
  String iBPU;
  int iTOTAL;
  int iRETURN;

  GetHisBasketResp(
      {this.cBASKCD, this.cBASKNM, this.iBPU, this.iTOTAL, this.iRETURN});

  GetHisBasketResp.fromJson(Map<String, dynamic> json) {
    cBASKCD = json['cBASKCD'];
    cBASKNM = json['cBASKNM'];
    iBPU = json['iBPU'];
    iTOTAL = json['iTOTAL'];
    iRETURN = json['iRETURN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBASKCD'] = this.cBASKCD;
    data['cBASKNM'] = this.cBASKNM;
    data['iBPU'] = this.iBPU;
    data['iTOTAL'] = this.iTOTAL;
    data['iRETURN'] = this.iRETURN;
    return data;
  }
}