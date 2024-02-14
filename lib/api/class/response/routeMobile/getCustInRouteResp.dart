class GetCustInRouteResp {
  String cCUSTCD;
  String cCUSTNM;
  String cADDRESS;
  String cSUBDIST;
  String cDISTRICT;
  String cPROVINCE;
  String cPOSTCD;
  String cBRANCD;
  String cGRPCD;
  String cRTECD;
  String cRTENM;
  String cLATITUDE;
  String cLONGTITUDE;
  String cPHOTOSERV;
  String cPHOTOPATH;
  String cDISTANCS;
  String cCONTACTTEL;

  GetCustInRouteResp(
      {this.cCUSTCD,
      this.cCUSTNM,
      this.cADDRESS,
      this.cSUBDIST,
      this.cDISTRICT,
      this.cPROVINCE,
      this.cPOSTCD,
      this.cBRANCD,
      this.cGRPCD,
      this.cRTECD,
      this.cRTENM,
      this.cLATITUDE,
      this.cLONGTITUDE,
      this.cPHOTOSERV,
      this.cPHOTOPATH,
      this.cDISTANCS,
      this.cCONTACTTEL});

  GetCustInRouteResp.fromJson(Map<String, dynamic> json) {
    cCUSTCD = json['cCUSTCD'];
    cCUSTNM = json['cCUSTNM'];
    cADDRESS = json['cADDRESS'];
    cSUBDIST = json['cSUBDIST'];
    cDISTRICT = json['cDISTRICT'];
    cPROVINCE = json['cPROVINCE'];
    cPOSTCD = json['cPOSTCD'];
    cBRANCD = json['cBRANCD'];
    cGRPCD = json['cGRPCD'];
    cRTECD = json['cRTECD'];
    cRTENM = json['cRTENM'];
    cLATITUDE = json['cLATITUDE'];
    cLONGTITUDE = json['cLONGTITUDE'];
    cPHOTOSERV = json['cPHOTO_SERV'];
    cPHOTOPATH = json['cPHOTO_PATH'];
    cDISTANCS = json['cDISTANCS'];
    cCONTACTTEL = json['cCONTACT_TEL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cCUSTCD'] = this.cCUSTCD;
    data['cCUSTNM'] = this.cCUSTNM;
    data['cADDRESS'] = this.cADDRESS;
    data['cSUBDIST'] = this.cSUBDIST;
    data['cDISTRICT'] = this.cDISTRICT;
    data['cPROVINCE'] = this.cPROVINCE;
    data['cPOSTCD'] = this.cPOSTCD;
    data['cBRANCD'] = this.cBRANCD;
    data['cGRPCD'] = this.cGRPCD;
    data['cRTECD'] = this.cRTECD;
    data['cRTENM'] = this.cRTENM;
    data['cLATITUDE'] = this.cLATITUDE;
    data['cLONGTITUDE'] = this.cLONGTITUDE;
    data['cPHOTO_SERV'] = this.cPHOTOSERV;
    data['cPHOTO_PATH'] = this.cPHOTOPATH;
    data['cDISTANCS'] = this.cDISTANCS;
    data['cCONTACT_TEL'] = this.cCONTACTTEL;
    return data;
  }
}