class LocationStoreResp {
  String? cGUID;
  String? cCUSTCD;
  String? cLATITUDE;
  String? cLONGTITUDE;
  String? dUPDADT;
  String? cUPDABY;

  LocationStoreResp(
      {this.cGUID,
      this.cCUSTCD,
      this.cLATITUDE,
      this.cLONGTITUDE,
      this.dUPDADT,
      this.cUPDABY});

  LocationStoreResp.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
    cCUSTCD = json['cCUSTCD'];
    cLATITUDE = json['cLATITUDE'];
    cLONGTITUDE = json['cLONGTITUDE'];
    dUPDADT = json['dUPDADT'];
    cUPDABY = json['cUPDABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    data['cCUSTCD'] = this.cCUSTCD;
    data['cLATITUDE'] = this.cLATITUDE;
    data['cLONGTITUDE'] = this.cLONGTITUDE;
    data['dUPDADT'] = this.dUPDADT;
    data['cUPDABY'] = this.cUPDABY;
    return data;
  }
}
