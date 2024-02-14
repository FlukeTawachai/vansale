class AddRTPROReq {
  String cBRANCD;
  String cPOCD;
  String cCUSTCD;
  String cPRODCD;
  String iQTY;
  String iTOTAL;
  String cSTATUS;
  String cUOMCD;
  String cCREABY;

  AddRTPROReq(
      {this.cBRANCD,
      this.cPOCD,
      this.cCUSTCD,
      this.cPRODCD,
      this.iQTY,
      this.iTOTAL,
      this.cSTATUS,
      this.cUOMCD,
      this.cCREABY});

  AddRTPROReq.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cPOCD = json['cPOCD'];
    cCUSTCD = json['cCUSTCD'];
    cPRODCD = json['cPRODCD'];
    iQTY = json['iQTY'];
    iTOTAL = json['iTOTAL'];
    cSTATUS = json['cSTATUS'];
    cUOMCD = json['cUOMCD'];
    cCREABY = json['cCREABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['cPOCD'] = this.cPOCD;
    data['cCUSTCD'] = this.cCUSTCD;
    data['cPRODCD'] = this.cPRODCD;
    data['iQTY'] = this.iQTY;
    data['iTOTAL'] = this.iTOTAL;
    data['cSTATUS'] = this.cSTATUS;
    data['cUOMCD'] = this.cUOMCD;
    data['cCREABY'] = this.cCREABY;
    return data;
  }
}