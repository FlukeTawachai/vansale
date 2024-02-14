class UpdateReturnHDReq {
  String? cRETCD;
  String? cBRANCD;
  String? cGRPCD;
  String? cRTECD;
  String? cCUSTCD;
  String? cCUSTNM;
  String? cVEHICD;
  String? cDRIVER;
  String? cREMARK;
  String? iTOTAL;
  String? cREFDOC;
  String? cRETYP;
  String? cPAYST;
  String? cCREABY;

  UpdateReturnHDReq(
      {this.cRETCD,
      this.cBRANCD,
      this.cGRPCD,
      this.cRTECD,
      this.cCUSTCD,
      this.cCUSTNM,
      this.cVEHICD,
      this.cDRIVER,
      this.cREMARK,
      this.iTOTAL,
      this.cREFDOC,
      this.cRETYP,
      this.cPAYST,
      this.cCREABY});

  UpdateReturnHDReq.fromJson(Map<String, dynamic> json) {
    cRETCD = json['cRETCD'];
    cBRANCD = json['cBRANCD'];
    cGRPCD = json['cGRPCD'];
    cRTECD = json['cRTECD'];
    cCUSTCD = json['cCUSTCD'];
    cCUSTNM = json['cCUSTNM'];
    cVEHICD = json['cVEHICD'];
    cDRIVER = json['cDRIVER'];
    cREMARK = json['cREMARK'];
    iTOTAL = json['iTOTAL'];
    cREFDOC = json['cREFDOC'];
    cRETYP = json['cRETYP'];
    cPAYST = json['cPAYST'];
    cCREABY = json['cCREABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cRETCD'] = this.cRETCD;
    data['cBRANCD'] = this.cBRANCD;
    data['cGRPCD'] = this.cGRPCD;
    data['cRTECD'] = this.cRTECD;
    data['cCUSTCD'] = this.cCUSTCD;
    data['cCUSTNM'] = this.cCUSTNM;
    data['cVEHICD'] = this.cVEHICD;
    data['cDRIVER'] = this.cDRIVER;
    data['cREMARK'] = this.cREMARK;
    data['iTOTAL'] = this.iTOTAL;
    data['cREFDOC'] = this.cREFDOC;
    data['cRETYP'] = this.cRETYP;
    data['cPAYST'] = this.cPAYST;
    data['cCREABY'] = this.cCREABY;
    return data;
  }
}