class GetCustomerPOHisResp {
  String? cGUID;
  String? cPOCD;
  String? dPODATE;
  String? cPOSTATUS;
  String? cBRANCD;
  String? cBRANNM;
  String? cCUSTCD;
  String? cCUSTNM;
  String? cADDRESS;
  String? dTAXDATE;
  String? cTAXNO;
  String? cPAYTYPE;
  String? dDUEDATE;
  String? dSHIPDATE;
  String? cSHIPNO;
  String? cSHIPTO;
  String? cREFDOC;
  String? cGRPCD;
  String? cRTECD;
  String? cVEHICD;
  String? cDRIVER;
  String? cPLATE;
  String? cPROVINCE;
  String? iCAP;
  String? iWEIGHT;
  String? iPRODVAL;
  String? iDEPOSIT;
  String? iBEFOREVAT;
  String? iVATVAL;
  String? iSKIPVAT;
  String? iDPBASKET;
  String? iTOTAL;
  String? iPAID;
  String? cREMARK;
  String? dCREADT;
  String? cCREABY;
  String? dUPDADT;
  String? cUPDABY;
  String? cPREPAIRCFSTATUS;
  String? iBASKETTOTAL;

  GetCustomerPOHisResp(
      {this.cGUID,
      this.cPOCD,
      this.dPODATE,
      this.cPOSTATUS,
      this.cBRANCD,
      this.cBRANNM,
      this.cCUSTCD,
      this.cCUSTNM,
      this.cADDRESS,
      this.dTAXDATE,
      this.cTAXNO,
      this.cPAYTYPE,
      this.dDUEDATE,
      this.dSHIPDATE,
      this.cSHIPNO,
      this.cSHIPTO,
      this.cREFDOC,
      this.cGRPCD,
      this.cRTECD,
      this.cVEHICD,
      this.cDRIVER,
      this.cPLATE,
      this.cPROVINCE,
      this.iCAP,
      this.iWEIGHT,
      this.iPRODVAL,
      this.iDEPOSIT,
      this.iBEFOREVAT,
      this.iVATVAL,
      this.iSKIPVAT,
      this.iDPBASKET,
      this.iTOTAL,
      this.iPAID,
      this.cREMARK,
      this.dCREADT,
      this.cCREABY,
      this.dUPDADT,
      this.cUPDABY,
      this.cPREPAIRCFSTATUS,
      this.iBASKETTOTAL});

  GetCustomerPOHisResp.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
    cPOCD = json['cPOCD'];
    dPODATE = json['dPODATE'];
    cPOSTATUS = json['cPOSTATUS'];
    cBRANCD = json['cBRANCD'];
    cBRANNM = json['cBRANNM'];
    cCUSTCD = json['cCUSTCD'];
    cCUSTNM = json['cCUSTNM'];
    cADDRESS = json['cADDRESS'];
    dTAXDATE = json['dTAXDATE'];
    cTAXNO = json['cTAXNO'];
    cPAYTYPE = json['cPAYTYPE'];
    dDUEDATE = json['dDUEDATE'];
    dSHIPDATE = json['dSHIPDATE'];
    cSHIPNO = json['cSHIPNO'];
    cSHIPTO = json['cSHIPTO'];
    cREFDOC = json['cREFDOC'];
    cGRPCD = json['cGRPCD'];
    cRTECD = json['cRTECD'];
    cVEHICD = json['cVEHICD'];
    cDRIVER = json['cDRIVER'];
    cPLATE = json['cPLATE'];
    cPROVINCE = json['cPROVINCE'];
    iCAP = json['iCAP'];
    iWEIGHT = json['iWEIGHT'];
    iPRODVAL = json['iPROD_VAL'];
    iDEPOSIT = json['iDEPOSIT'];
    iBEFOREVAT = json['iBEFORE_VAT'];
    iVATVAL = json['iVAT_VAL'];
    iSKIPVAT = json['iSKIP_VAT'];
    iDPBASKET = json['iDPBASKET'];
    iTOTAL = json['iTOTAL'];
    iPAID = json['iPAID'];
    cREMARK = json['cREMARK'];
    dCREADT = json['dCREADT'];
    cCREABY = json['cCREABY'];
    dUPDADT = json['dUPDADT'];
    cUPDABY = json['cUPDABY'];
    cPREPAIRCFSTATUS = json['cPREPAIRCFSTATUS'];
    iBASKETTOTAL = json['iBASKETTOTAL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    data['cPOCD'] = this.cPOCD;
    data['dPODATE'] = this.dPODATE;
    data['cPOSTATUS'] = this.cPOSTATUS;
    data['cBRANCD'] = this.cBRANCD;
    data['cBRANNM'] = this.cBRANNM;
    data['cCUSTCD'] = this.cCUSTCD;
    data['cCUSTNM'] = this.cCUSTNM;
    data['cADDRESS'] = this.cADDRESS;
    data['dTAXDATE'] = this.dTAXDATE;
    data['cTAXNO'] = this.cTAXNO;
    data['cPAYTYPE'] = this.cPAYTYPE;
    data['dDUEDATE'] = this.dDUEDATE;
    data['dSHIPDATE'] = this.dSHIPDATE;
    data['cSHIPNO'] = this.cSHIPNO;
    data['cSHIPTO'] = this.cSHIPTO;
    data['cREFDOC'] = this.cREFDOC;
    data['cGRPCD'] = this.cGRPCD;
    data['cRTECD'] = this.cRTECD;
    data['cVEHICD'] = this.cVEHICD;
    data['cDRIVER'] = this.cDRIVER;
    data['cPLATE'] = this.cPLATE;
    data['cPROVINCE'] = this.cPROVINCE;
    data['iCAP'] = this.iCAP;
    data['iWEIGHT'] = this.iWEIGHT;
    data['iPROD_VAL'] = this.iPRODVAL;
    data['iDEPOSIT'] = this.iDEPOSIT;
    data['iBEFORE_VAT'] = this.iBEFOREVAT;
    data['iVAT_VAL'] = this.iVATVAL;
    data['iSKIP_VAT'] = this.iSKIPVAT;
    data['iDPBASKET'] = this.iDPBASKET;
    data['iTOTAL'] = this.iTOTAL;
    data['iPAID'] = this.iPAID;
    data['cREMARK'] = this.cREMARK;
    data['dCREADT'] = this.dCREADT;
    data['cCREABY'] = this.cCREABY;
    data['dUPDADT'] = this.dUPDADT;
    data['cUPDABY'] = this.cUPDABY;
    data['cPREPAIRCFSTATUS'] = this.cPREPAIRCFSTATUS;
    data['iBASKETTOTAL'] = this.iBASKETTOTAL;
    return data;
  }
}
