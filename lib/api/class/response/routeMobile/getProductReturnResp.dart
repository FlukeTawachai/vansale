class GetProductReturnResp {
  String? cGUID;
  String? cPOCD;
  String? cCUSTCD;
  String? cPRODCD;
  int? iQTY;
  String? iTOTAL;
  String? cSTATUS;
  String? cRTS;
  String? cCREABY;
  String? cUPDABY;
  String? dCREADT;
  String? dUPDADT;
  String? cBRANCD;
  String? cRTBSTOCK;
  String? cUOMCD;
  String? cUOMNM;

  GetProductReturnResp(
      {this.cGUID,
      this.cPOCD,
      this.cCUSTCD,
      this.cPRODCD,
      this.iQTY,
      this.iTOTAL,
      this.cSTATUS,
      this.cRTS,
      this.cCREABY,
      this.cUPDABY,
      this.dCREADT,
      this.dUPDADT,
      this.cBRANCD,
      this.cRTBSTOCK,
      this.cUOMCD,
      this.cUOMNM});

  GetProductReturnResp.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
    cPOCD = json['cPOCD'];
    cCUSTCD = json['cCUSTCD'];
    cPRODCD = json['cPRODCD'];
    iQTY = json['iQTY'];
    iTOTAL = json['iTOTAL'];
    cSTATUS = json['cSTATUS'];
    cRTS = json['cRTS'];
    cCREABY = json['cCREABY'];
    cUPDABY = json['cUPDABY'];
    dCREADT = json['dCREADT'];
    dUPDADT = json['dUPDADT'];
    cBRANCD = json['cBRANCD'];
    cRTBSTOCK = json['cRTBSTOCK'];
    cUOMCD = json['cUOMCD'];
    cUOMNM = json['cUOMNM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    data['cPOCD'] = this.cPOCD;
    data['cCUSTCD'] = this.cCUSTCD;
    data['cPRODCD'] = this.cPRODCD;
    data['iQTY'] = this.iQTY;
    data['iTOTAL'] = this.iTOTAL;
    data['cSTATUS'] = this.cSTATUS;
    data['cRTS'] = this.cRTS;
    data['cCREABY'] = this.cCREABY;
    data['cUPDABY'] = this.cUPDABY;
    data['dCREADT'] = this.dCREADT;
    data['dUPDADT'] = this.dUPDADT;
    data['cBRANCD'] = this.cBRANCD;
    data['cRTBSTOCK'] = this.cRTBSTOCK;
    data['cUOMCD'] = this.cUOMCD;
    data['cUOMNM'] = this.cUOMNM;
    return data;
  }
}
