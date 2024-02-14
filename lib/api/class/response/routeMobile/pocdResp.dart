class PocdResp {
  String? cCUSTCD;
  String? cPOCD;
  String? dPODATE;
  String? dSHIPDATE;

  PocdResp({this.cCUSTCD, this.cPOCD, this.dPODATE, this.dSHIPDATE});

  PocdResp.fromJson(Map<String, dynamic> json) {
    cCUSTCD = json['cCUSTCD'];
    cPOCD = json['cPOCD'];
    dPODATE = json['dPODATE'];
    dSHIPDATE = json['dSHIPDATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cCUSTCD'] = this.cCUSTCD;
    data['cPOCD'] = this.cPOCD;
    data['dPODATE'] = this.dPODATE;
    data['dSHIPDATE'] = this.dSHIPDATE;
    return data;
  }
}
