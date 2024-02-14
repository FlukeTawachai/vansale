class GetSupplierOrderResp {
  String? cGUID;
  String? cPOCD;
  String? dPODATE;
  String? cPOSTATUS;
  String? cBRANCD;
  String? cBRANNM;
  String? cSUPPCD;
  String? cSUPPNM;
  String? cPROVINCE;
  String? cVEHICD;
  String? cDRIVER;
  String? cPLATE;
  String? cPPROVINCE;
  String? iCAPVEH;
  String? iCAPPROD;
  String? iCAPDIFF;
  String? iWEIGHTVEH;
  String? iWEIGHTPROD;
  String? iWEIGHTDIFF;
  String? iBEFOREVAT;
  String? iVATVAL;
  String? iSKIPVAT;
  String? iDPBASKET;
  String? iTOTAL;
  String? iPAID;
  String? cREMARK;
  String? iBASKETTOTAL;
  String? cDELFLAG;
  String? cCREATYPE;
  String? dCREADT;
  String? cCREABY;
  String? dUPDADT;
  String? cUPDABY;
  String? dREFDATE;

  GetSupplierOrderResp(
      {this.cGUID,
      this.cPOCD,
      this.dPODATE,
      this.cPOSTATUS,
      this.cBRANCD,
      this.cBRANNM,
      this.cSUPPCD,
      this.cSUPPNM,
      this.cPROVINCE,
      this.cVEHICD,
      this.cDRIVER,
      this.cPLATE,
      this.cPPROVINCE,
      this.iCAPVEH,
      this.iCAPPROD,
      this.iCAPDIFF,
      this.iWEIGHTVEH,
      this.iWEIGHTPROD,
      this.iWEIGHTDIFF,
      this.iBEFOREVAT,
      this.iVATVAL,
      this.iSKIPVAT,
      this.iDPBASKET,
      this.iTOTAL,
      this.iPAID,
      this.cREMARK,
      this.iBASKETTOTAL,
      this.cDELFLAG,
      this.cCREATYPE,
      this.dCREADT,
      this.cCREABY,
      this.dUPDADT,
      this.cUPDABY,
      this.dREFDATE});

  GetSupplierOrderResp.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
    cPOCD = json['cPOCD'];
    dPODATE = json['dPODATE'];
    cPOSTATUS = json['cPOSTATUS'];
    cBRANCD = json['cBRANCD'];
    cBRANNM = json['cBRANNM'];
    cSUPPCD = json['cSUPPCD'];
    cSUPPNM = json['cSUPPNM'];
    cPROVINCE = json['cPROVINCE'];
    cVEHICD = json['cVEHICD'];
    cDRIVER = json['cDRIVER'];
    cPLATE = json['cPLATE'];
    cPPROVINCE = json['cPPROVINCE'];
    iCAPVEH = json['iCAP_VEH'];
    iCAPPROD = json['iCAP_PROD'];
    iCAPDIFF = json['iCAP_DIFF'];
    iWEIGHTVEH = json['iWEIGHT_VEH'];
    iWEIGHTPROD = json['iWEIGHT_PROD'];
    iWEIGHTDIFF = json['iWEIGHT_DIFF'];
    iBEFOREVAT = json['iBEFORE_VAT'];
    iVATVAL = json['iVAT_VAL'];
    iSKIPVAT = json['iSKIP_VAT'];
    iDPBASKET = json['iDPBASKET'];
    iTOTAL = json['iTOTAL'];
    iPAID = json['iPAID'];
    cREMARK = json['cREMARK'];
    iBASKETTOTAL = json['iBASKETTOTAL'];
    cDELFLAG = json['cDELFLAG'];
    cCREATYPE = json['cCREATYPE'];
    dCREADT = json['dCREADT'];
    cCREABY = json['cCREABY'];
    dUPDADT = json['dUPDADT'];
    cUPDABY = json['cUPDABY'];
    dREFDATE = json['dREF_DATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    data['cPOCD'] = this.cPOCD;
    data['dPODATE'] = this.dPODATE;
    data['cPOSTATUS'] = this.cPOSTATUS;
    data['cBRANCD'] = this.cBRANCD;
    data['cBRANNM'] = this.cBRANNM;
    data['cSUPPCD'] = this.cSUPPCD;
    data['cSUPPNM'] = this.cSUPPNM;
    data['cPROVINCE'] = this.cPROVINCE;
    data['cVEHICD'] = this.cVEHICD;
    data['cDRIVER'] = this.cDRIVER;
    data['cPLATE'] = this.cPLATE;
    data['cPPROVINCE'] = this.cPPROVINCE;
    data['iCAP_VEH'] = this.iCAPVEH;
    data['iCAP_PROD'] = this.iCAPPROD;
    data['iCAP_DIFF'] = this.iCAPDIFF;
    data['iWEIGHT_VEH'] = this.iWEIGHTVEH;
    data['iWEIGHT_PROD'] = this.iWEIGHTPROD;
    data['iWEIGHT_DIFF'] = this.iWEIGHTDIFF;
    data['iBEFORE_VAT'] = this.iBEFOREVAT;
    data['iVAT_VAL'] = this.iVATVAL;
    data['iSKIP_VAT'] = this.iSKIPVAT;
    data['iDPBASKET'] = this.iDPBASKET;
    data['iTOTAL'] = this.iTOTAL;
    data['iPAID'] = this.iPAID;
    data['cREMARK'] = this.cREMARK;
    data['iBASKETTOTAL'] = this.iBASKETTOTAL;
    data['cDELFLAG'] = this.cDELFLAG;
    data['cCREATYPE'] = this.cCREATYPE;
    data['dCREADT'] = this.dCREADT;
    data['cCREABY'] = this.cCREABY;
    data['dUPDADT'] = this.dUPDADT;
    data['cUPDABY'] = this.cUPDABY;
    data['dREF_DATE'] = this.dREFDATE;
    return data;
  }
}
