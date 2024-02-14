class PoHDAndPoDTResp {
  String cCUSTCD;
  String cTYPE;
  String cPOCD;
  String cPRODCD;
  String cPRODNM;
  String cBASKCD;
  String cBASKNM;
  String iitems;
  String ibasket;
  String iTOTAL;

  PoHDAndPoDTResp(
      {this.cCUSTCD,
      this.cTYPE,
      this.cPOCD,
      this.cPRODCD,
      this.cPRODNM,
      this.cBASKCD,
      this.cBASKNM,
      this.iitems,
      this.ibasket,
      this.iTOTAL});

  PoHDAndPoDTResp.fromJson(Map<String, dynamic> json) {
    cCUSTCD = json['cCUSTCD'];
    cTYPE = json['cTYPE'];
    cPOCD = json['cPOCD'];
    cPRODCD = json['cPRODCD'];
    cPRODNM = json['cPRODNM'];
    cBASKCD = json['cBASKCD'];
    cBASKNM = json['cBASKNM'];
    iitems = json['iitems'];
    ibasket = json['ibasket'];
    iTOTAL = json['iTOTAL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cCUSTCD'] = this.cCUSTCD;
    data['cTYPE'] = this.cTYPE;
    data['cPOCD'] = this.cPOCD;
    data['cPRODCD'] = this.cPRODCD;
    data['cPRODNM'] = this.cPRODNM;
    data['cBASKCD'] = this.cBASKCD;
    data['cBASKNM'] = this.cBASKNM;
    data['iitems'] = this.iitems;
    data['ibasket'] = this.ibasket;
    data['iTOTAL'] = this.iTOTAL;
    return data;
  }
}