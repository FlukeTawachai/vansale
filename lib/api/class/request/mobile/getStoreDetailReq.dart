class GetStoreDetailReq {
  String cCUSTCD;
  String cPRODNM;
  String cPRODCD;

  GetStoreDetailReq({this.cCUSTCD, this.cPRODNM, this.cPRODCD});

  GetStoreDetailReq.fromJson(Map<String, dynamic> json) {
    cCUSTCD = json['cCUSTCD'];
    cPRODNM = json['cPRODNM'];
    cPRODCD = json['cPRODCD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cCUSTCD'] = this.cCUSTCD;
    data['cPRODNM'] = this.cPRODNM;
    data['cPRODCD'] = this.cPRODCD;
    return data;
  }
}