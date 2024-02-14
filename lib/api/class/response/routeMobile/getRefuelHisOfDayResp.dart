class GetRefuelHisOfDayResp {
  String cGUID;
  String cBRANCD;
  String dINVENTDT;
  String cVEHICD;
  String cVEHINM;
  String cPLATE;
  String cPROVINCE;
  String cLOCATION;
  String cFUELNM;
  String iMILEAGE;
  String iKM;
  String iFUELRATE;
  String iLITER;
  String iPRICE;
  String iTOTAL;
  String cCREABY;
  String cUPDABY;
  String dCREADT;
  String dUPDADT;
  String cREFDOC;

  GetRefuelHisOfDayResp(
      {this.cGUID,
      this.cBRANCD,
      this.dINVENTDT,
      this.cVEHICD,
      this.cVEHINM,
      this.cPLATE,
      this.cPROVINCE,
      this.cLOCATION,
      this.cFUELNM,
      this.iMILEAGE,
      this.iKM,
      this.iFUELRATE,
      this.iLITER,
      this.iPRICE,
      this.iTOTAL,
      this.cCREABY,
      this.cUPDABY,
      this.dCREADT,
      this.dUPDADT,
      this.cREFDOC});

  GetRefuelHisOfDayResp.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
    cBRANCD = json['cBRANCD'];
    dINVENTDT = json['dINVENT_DT'];
    cVEHICD = json['cVEHICD'];
    cVEHINM = json['cVEHINM'];
    cPLATE = json['cPLATE'];
    cPROVINCE = json['cPROVINCE'];
    cLOCATION = json['cLOCATION'];
    cFUELNM = json['cFUELNM'];
    iMILEAGE = json['iMILEAGE'];
    iKM = json['iKM'];
    iFUELRATE = json['iFUELRATE'];
    iLITER = json['iLITER'];
    iPRICE = json['iPRICE'];
    iTOTAL = json['iTOTAL'];
    cCREABY = json['cCREABY'];
    cUPDABY = json['cUPDABY'];
    dCREADT = json['dCREADT'];
    dUPDADT = json['dUPDADT'];
    cREFDOC = json['cREFDOC'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    data['cBRANCD'] = this.cBRANCD;
    data['dINVENT_DT'] = this.dINVENTDT;
    data['cVEHICD'] = this.cVEHICD;
    data['cVEHINM'] = this.cVEHINM;
    data['cPLATE'] = this.cPLATE;
    data['cPROVINCE'] = this.cPROVINCE;
    data['cLOCATION'] = this.cLOCATION;
    data['cFUELNM'] = this.cFUELNM;
    data['iMILEAGE'] = this.iMILEAGE;
    data['iKM'] = this.iKM;
    data['iFUELRATE'] = this.iFUELRATE;
    data['iLITER'] = this.iLITER;
    data['iPRICE'] = this.iPRICE;
    data['iTOTAL'] = this.iTOTAL;
    data['cCREABY'] = this.cCREABY;
    data['cUPDABY'] = this.cUPDABY;
    data['dCREADT'] = this.dCREADT;
    data['dUPDADT'] = this.dUPDADT;
    data['cREFDOC'] = this.cREFDOC;
    return data;
  }
}