class AddRefuelReq {
  String cBRANCD;
  String cVEHICD;
  String cVEHINM;
  String cLOCATION;
  String cFUELNM;
  double iMILEAGE;
  double iKM;
  double iFUELRATE;
  double iLITER;
  double iPRICE;
  String cPLATE;
  String cPROVINCE;
  String cREFDOC;
  String cCREABY;

  AddRefuelReq(
      {this.cBRANCD,
      this.cVEHICD,
      this.cVEHINM,
      this.cLOCATION,
      this.cFUELNM,
      this.iMILEAGE,
      this.iKM,
      this.iFUELRATE,
      this.iLITER,
      this.iPRICE,
      this.cPLATE,
      this.cPROVINCE,
      this.cREFDOC,
      this.cCREABY});

  AddRefuelReq.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cVEHICD = json['cVEHICD'];
    cVEHINM = json['cVEHINM'];
    cLOCATION = json['cLOCATION'];
    cFUELNM = json['cFUELNM'];
    iMILEAGE = json['iMILEAGE'];
    iKM = json['iKM'];
    iFUELRATE = json['iFUELRATE'];
    iLITER = json['iLITER'];
    iPRICE = json['iPRICE'];
    cPLATE = json['cPLATE'];
    cPROVINCE = json['cPROVINCE'];
    cREFDOC = json['cREFDOC'];
    cCREABY = json['cCREABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['cVEHICD'] = this.cVEHICD;
    data['cVEHINM'] = this.cVEHINM;
    data['cLOCATION'] = this.cLOCATION;
    data['cFUELNM'] = this.cFUELNM;
    data['iMILEAGE'] = this.iMILEAGE;
    data['iKM'] = this.iKM;
    data['iFUELRATE'] = this.iFUELRATE;
    data['iLITER'] = this.iLITER;
    data['iPRICE'] = this.iPRICE;
    data['cPLATE'] = this.cPLATE;
    data['cPROVINCE'] = this.cPROVINCE;
    data['cREFDOC'] = this.cREFDOC;
    data['cCREABY'] = this.cCREABY;
    return data;
  }
}