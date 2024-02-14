class AddSendMoneyReq {
  String cBRANCD;
  String cGRPCD;
  String cRTECD;
  String cVEHICD;
  String cDRIVER;
  double iTOTAL;
  double iCOST;
  String cBILLPH;
  String cCOSTPH;
  String cCOSNM;
  String cREMARK;
  double iREFUEL;
  String cCREABY;
  String cSERVER;

  AddSendMoneyReq(
      {this.cBRANCD,
      this.cGRPCD,
      this.cRTECD,
      this.cVEHICD,
      this.cDRIVER,
      this.iTOTAL,
      this.iCOST,
      this.cBILLPH,
      this.cCOSTPH,
      this.cCOSNM,
      this.cREMARK,
      this.iREFUEL,
      this.cCREABY,
      this.cSERVER});

  AddSendMoneyReq.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cGRPCD = json['cGRPCD'];
    cRTECD = json['cRTECD'];
    cVEHICD = json['cVEHICD'];
    cDRIVER = json['cDRIVER'];
    iTOTAL = json['iTOTAL'];
    iCOST = json['iCOST'];
    cBILLPH = json['cBILLPH'];
    cCOSTPH = json['cCOSTPH'];
    cCOSNM = json['cCOSNM'];
    cREMARK = json['cREMARK'];
    iREFUEL = json['iREFUEL'];
    cCREABY = json['cCREABY'];
    cSERVER = json['cSERVER'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['cGRPCD'] = this.cGRPCD;
    data['cRTECD'] = this.cRTECD;
    data['cVEHICD'] = this.cVEHICD;
    data['cDRIVER'] = this.cDRIVER;
    data['iTOTAL'] = this.iTOTAL;
    data['iCOST'] = this.iCOST;
    data['cBILLPH'] = this.cBILLPH;
    data['cCOSTPH'] = this.cCOSTPH;
    data['cCOSNM'] = this.cCOSNM;
    data['cREMARK'] = this.cREMARK;
    data['iREFUEL'] = this.iREFUEL;
    data['cCREABY'] = this.cCREABY;
    data['cSERVER'] = this.cSERVER;
    return data;
  }
}