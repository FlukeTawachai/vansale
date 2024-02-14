class PocdReq {
  String? cCUSTCD;
  String? dSHIPDATE;

  PocdReq({this.cCUSTCD, this.dSHIPDATE});

  PocdReq.fromJson(Map<String, dynamic> json) {
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