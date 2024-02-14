class QueryPodtReq {
  String? cPOCD;
  String? cPRODNM;
  String? cPRODCD;
  String? cCUSTTYPE;

  QueryPodtReq({this.cPOCD, this.cPRODNM, this.cPRODCD, this.cCUSTTYPE});

  QueryPodtReq.fromJson(Map<String, dynamic> json) {
    cPOCD = json['cPOCD'];
    cPRODNM = json['cPRODNM'];
    cPRODCD = json['cPRODCD'];
    cCUSTTYPE = json['cCUSTTYPE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cPOCD'] = this.cPOCD;
    data['cPRODNM'] = this.cPRODNM;
    data['cPRODCD'] = this.cPRODCD;
    data['cCUSTTYPE'] = this.cCUSTTYPE;
    return data;
  }
}