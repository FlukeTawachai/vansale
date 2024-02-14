class PoHDAndPoDTReq {
  String? custcd;
  String? pocd;
  String? cPRODNM;
  String? cPRODCD;

  PoHDAndPoDTReq({this.custcd, this.pocd, this.cPRODNM, this.cPRODCD});

  PoHDAndPoDTReq.fromJson(Map<String, dynamic> json) {
    custcd = json['custcd'];
    pocd = json['pocd'];
    cPRODNM = json['cPRODNM'];
    cPRODCD = json['cPRODCD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['custcd'] = this.custcd;
    data['pocd'] = this.pocd;
    data['cPRODNM'] = this.cPRODNM;
    data['cPRODCD'] = this.cPRODCD;
    return data;
  }
}