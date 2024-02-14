class GetSumMoneyResp {
  String? cBRANCD;
  String? cGRPCD;
  String? cRTECD;
  String? dSHIPDATE;
  String? iTOTAL;
  String? iCASH;
  String? iTRANSFER;
  String? iCHECK;
  String? iWAGE;
  String? iTOTALWAGE;
  String? iOLEWAGE;
  String? iNEWWAGE;

  GetSumMoneyResp(
      {this.cBRANCD,
      this.cGRPCD,
      this.cRTECD,
      this.dSHIPDATE,
      this.iTOTAL,
      this.iCASH,
      this.iTRANSFER,
      this.iCHECK,
      this.iWAGE,
      this.iTOTALWAGE,
      this.iOLEWAGE,
      this.iNEWWAGE});

  GetSumMoneyResp.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cGRPCD = json['cGRPCD'];
    cRTECD = json['cRTECD'];
    dSHIPDATE = json['dSHIPDATE'];
    iTOTAL = json['iTOTAL'];
    iCASH = json['iCASH'];
    iTRANSFER = json['iTRANSFER'];
    iCHECK = json['iCHECK'];
    iWAGE = json['iWAGE'];
    iTOTALWAGE = json['iTOTALWAGE'];
    iOLEWAGE = json['iOLEWAGE'];
    iNEWWAGE = json['iNEWWAGE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['cGRPCD'] = this.cGRPCD;
    data['cRTECD'] = this.cRTECD;
    data['dSHIPDATE'] = this.dSHIPDATE;
    data['iTOTAL'] = this.iTOTAL;
    data['iCASH'] = this.iCASH;
    data['iTRANSFER'] = this.iTRANSFER;
    data['iCHECK'] = this.iCHECK;
    data['iWAGE'] = this.iWAGE;
    data['iTOTALWAGE'] = this.iTOTALWAGE;
    data['iOLEWAGE'] = this.iOLEWAGE;
    data['iNEWWAGE'] = this.iNEWWAGE;
    return data;
  }
}
