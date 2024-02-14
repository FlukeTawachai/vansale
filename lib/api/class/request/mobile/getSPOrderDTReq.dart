class GetSPOrderDTReq {
  String? cPOCD;
  String? cPRODNM;
  String? cPRODCD;

  GetSPOrderDTReq({this.cPOCD, this.cPRODNM, this.cPRODCD});

  GetSPOrderDTReq.fromJson(Map<String, dynamic> json) {
    cPOCD = json['cPOCD'];
    cPRODNM = json['cPRODNM'];
    cPRODCD = json['cPRODCD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cPOCD'] = this.cPOCD;
    data['cPRODNM'] = this.cPRODNM;
    data['cPRODCD'] = this.cPRODCD;
    return data;
  }
}