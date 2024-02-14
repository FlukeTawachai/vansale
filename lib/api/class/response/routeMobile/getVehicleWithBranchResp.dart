class GetVehicleWithBranchResp {
  String? cGUID;
  String? cVEHICD;
  String? cVEHINM;
  String? cPLATE;
  String? cPROVINCE;
  String? cDRIVER;
  String? cVEHTYPE;
  String? cBRANCD;
  String? iTARGET;
  String? iVEHWEI;
  String? cDIMENT;
  String? iWEIGHT;
  String? iCAP;
  String? iTOTWEI;
  String? cSTATUS;
  String? dCREADT;
  String? cCREABY;
  String? dUPDADT;
  String? cUPDABY;
  String? cISPHOTO;
  String? cPHOTOSERV;
  String? cPHOTOPATH;
  String? cPHOTONM;

  GetVehicleWithBranchResp(
      {this.cGUID,
      this.cVEHICD,
      this.cVEHINM,
      this.cPLATE,
      this.cPROVINCE,
      this.cDRIVER,
      this.cVEHTYPE,
      this.cBRANCD,
      this.iTARGET,
      this.iVEHWEI,
      this.cDIMENT,
      this.iWEIGHT,
      this.iCAP,
      this.iTOTWEI,
      this.cSTATUS,
      this.dCREADT,
      this.cCREABY,
      this.dUPDADT,
      this.cUPDABY,
      this.cISPHOTO,
      this.cPHOTOSERV,
      this.cPHOTOPATH,
      this.cPHOTONM});

  GetVehicleWithBranchResp.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
    cVEHICD = json['cVEHICD'];
    cVEHINM = json['cVEHINM'];
    cPLATE = json['cPLATE'];
    cPROVINCE = json['cPROVINCE'];
    cDRIVER = json['cDRIVER'];
    cVEHTYPE = json['cVEHTYPE'];
    cBRANCD = json['cBRANCD'];
    iTARGET = json['iTARGET'];
    iVEHWEI = json['iVEHWEI'];
    cDIMENT = json['cDIMENT'];
    iWEIGHT = json['iWEIGHT'];
    iCAP = json['iCAP'];
    iTOTWEI = json['iTOTWEI'];
    cSTATUS = json['cSTATUS'];
    dCREADT = json['dCREADT'];
    cCREABY = json['cCREABY'];
    dUPDADT = json['dUPDADT'];
    cUPDABY = json['cUPDABY'];
    cISPHOTO = json['cISPHOTO'];
    cPHOTOSERV = json['cPHOTO_SERV'];
    cPHOTOPATH = json['cPHOTO_PATH'];
    cPHOTONM = json['cPHOTO_NM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    data['cVEHICD'] = this.cVEHICD;
    data['cVEHINM'] = this.cVEHINM;
    data['cPLATE'] = this.cPLATE;
    data['cPROVINCE'] = this.cPROVINCE;
    data['cDRIVER'] = this.cDRIVER;
    data['cVEHTYPE'] = this.cVEHTYPE;
    data['cBRANCD'] = this.cBRANCD;
    data['iTARGET'] = this.iTARGET;
    data['iVEHWEI'] = this.iVEHWEI;
    data['cDIMENT'] = this.cDIMENT;
    data['iWEIGHT'] = this.iWEIGHT;
    data['iCAP'] = this.iCAP;
    data['iTOTWEI'] = this.iTOTWEI;
    data['cSTATUS'] = this.cSTATUS;
    data['dCREADT'] = this.dCREADT;
    data['cCREABY'] = this.cCREABY;
    data['dUPDADT'] = this.dUPDADT;
    data['cUPDABY'] = this.cUPDABY;
    data['cISPHOTO'] = this.cISPHOTO;
    data['cPHOTO_SERV'] = this.cPHOTOSERV;
    data['cPHOTO_PATH'] = this.cPHOTOPATH;
    data['cPHOTO_NM'] = this.cPHOTONM;
    return data;
  }
}
