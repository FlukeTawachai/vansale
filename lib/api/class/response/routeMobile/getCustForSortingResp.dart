class GetCustForSortingResp {
  String? cBRANCD;
  String? cBRANNM;
  String? cGRPCD;
  String? cVEHICD;
  String? cVEHINM;
  String? cRTECD;
  String? cRTENM;
  String? cCUSTCD;
  String? cCUSTNM;
  String? cADDRESS;
  String? cSUBDIST;
  String? cDISTRICT;
  String? cPROVINCE;
  String? cPOSTCD;
  String? cDISTANCS;
  int? iSEQROUTE;

  GetCustForSortingResp(
      {this.cBRANCD,
      this.cBRANNM,
      this.cGRPCD,
      this.cVEHICD,
      this.cVEHINM,
      this.cRTECD,
      this.cRTENM,
      this.cCUSTCD,
      this.cCUSTNM,
      this.cADDRESS,
      this.cSUBDIST,
      this.cDISTRICT,
      this.cPROVINCE,
      this.cPOSTCD,
      this.cDISTANCS,
      this.iSEQROUTE});

  GetCustForSortingResp.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cBRANNM = json['cBRANNM'];
    cGRPCD = json['cGRPCD'];
    cVEHICD = json['cVEHICD'];
    cVEHINM = json['cVEHINM'];
    cRTECD = json['cRTECD'];
    cRTENM = json['cRTENM'];
    cCUSTCD = json['cCUSTCD'];
    cCUSTNM = json['cCUSTNM'];
    cADDRESS = json['cADDRESS'];
    cSUBDIST = json['cSUBDIST'];
    cDISTRICT = json['cDISTRICT'];
    cPROVINCE = json['cPROVINCE'];
    cPOSTCD = json['cPOSTCD'];
    cDISTANCS = json['cDISTANCS'];
    iSEQROUTE = json['iSEQROUTE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['cBRANNM'] = this.cBRANNM;
    data['cGRPCD'] = this.cGRPCD;
    data['cVEHICD'] = this.cVEHICD;
    data['cVEHINM'] = this.cVEHINM;
    data['cRTECD'] = this.cRTECD;
    data['cRTENM'] = this.cRTENM;
    data['cCUSTCD'] = this.cCUSTCD;
    data['cCUSTNM'] = this.cCUSTNM;
    data['cADDRESS'] = this.cADDRESS;
    data['cSUBDIST'] = this.cSUBDIST;
    data['cDISTRICT'] = this.cDISTRICT;
    data['cPROVINCE'] = this.cPROVINCE;
    data['cPOSTCD'] = this.cPOSTCD;
    data['cDISTANCS'] = this.cDISTANCS;
    data['iSEQROUTE'] = this.iSEQROUTE == null ? 0 : this.iSEQROUTE;
    return data;
  }
}
