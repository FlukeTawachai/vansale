class AddLOSSPROReq {
  String? cPOCD;
  String? cCUSTCD;
  String? iQTY;
  String? iTOTAL;
  String? cIB64;
  String? cSERVER;
  String? cCREABY;

  AddLOSSPROReq(
      {this.cPOCD,
      this.cCUSTCD,
      this.iQTY,
      this.iTOTAL,
      this.cIB64,
      this.cSERVER,
      this.cCREABY});

  AddLOSSPROReq.fromJson(Map<String, dynamic> json) {
    cPOCD = json['cPOCD'];
    cCUSTCD = json['cCUSTCD'];
    iQTY = json['iQTY'];
    iTOTAL = json['iTOTAL'];
    cIB64 = json['cIB64'];
    cSERVER = json['cSERVER'];
    cCREABY = json['cCREABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cPOCD'] = this.cPOCD;
    data['cCUSTCD'] = this.cCUSTCD;
    data['iQTY'] = this.iQTY;
    data['iTOTAL'] = this.iTOTAL;
    data['cIB64'] = this.cIB64;
    data['cSERVER'] = this.cSERVER;
    data['cCREABY'] = this.cCREABY;
    return data;
  }
}