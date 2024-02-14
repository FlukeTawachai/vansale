class GetRefuelResp {
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
  List<ARFIMAGE> aRFIMAGE;

  GetRefuelResp(
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
      this.cREFDOC,
      this.aRFIMAGE});

  GetRefuelResp.fromJson(Map<String, dynamic> json) {
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
    if (json['aRFIMAGE'] != null) {
      aRFIMAGE = <ARFIMAGE>[];
      json['aRFIMAGE'].forEach((v) {
        aRFIMAGE.add(new ARFIMAGE.fromJson(v));
      });
    }
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
    if (this.aRFIMAGE != null) {
      data['aRFIMAGE'] = this.aRFIMAGE.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ARFIMAGE {
  String cGUID;
  String cRECEIVENO;
  String dINVENTDT;
  int iSEQ;
  String cREFDOC;
  String cTYPE;
  String cPHOTOSERV;
  String cPHOTOPATH;
  String cPHOTONM;
  String cCREABY;
  String cUPDABY;
  String dCREADT;
  String dUPDADT;

  ARFIMAGE(
      {this.cGUID,
      this.cRECEIVENO,
      this.dINVENTDT,
      this.iSEQ,
      this.cREFDOC,
      this.cTYPE,
      this.cPHOTOSERV,
      this.cPHOTOPATH,
      this.cPHOTONM,
      this.cCREABY,
      this.cUPDABY,
      this.dCREADT,
      this.dUPDADT});

  ARFIMAGE.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
    cRECEIVENO = json['cRECEIVE_NO'];
    dINVENTDT = json['dINVENT_DT'];
    iSEQ = json['iSEQ'];
    cREFDOC = json['cREF_DOC'];
    cTYPE = json['cTYPE'];
    cPHOTOSERV = json['cPHOTO_SERV'];
    cPHOTOPATH = json['cPHOTO_PATH'];
    cPHOTONM = json['cPHOTO_NM'];
    cCREABY = json['cCREABY'];
    cUPDABY = json['cUPDABY'];
    dCREADT = json['dCREADT'];
    dUPDADT = json['dUPDADT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    data['cRECEIVE_NO'] = this.cRECEIVENO;
    data['dINVENT_DT'] = this.dINVENTDT;
    data['iSEQ'] = this.iSEQ;
    data['cREF_DOC'] = this.cREFDOC;
    data['cTYPE'] = this.cTYPE;
    data['cPHOTO_SERV'] = this.cPHOTOSERV;
    data['cPHOTO_PATH'] = this.cPHOTOPATH;
    data['cPHOTO_NM'] = this.cPHOTONM;
    data['cCREABY'] = this.cCREABY;
    data['cUPDABY'] = this.cUPDABY;
    data['dCREADT'] = this.dCREADT;
    data['dUPDADT'] = this.dUPDADT;
    return data;
  }
}