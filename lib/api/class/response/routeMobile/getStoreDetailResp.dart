class GetStoreDetailResp {
  String cCUSTCD;
  String cPOCD;
  String iTOTAL;
  String dSUCCDT;
  String dCANDT;
  String iCREDTERM;
  String iCREDLIM;
  String iPAID;
  String iPOTOTAL;

  GetStoreDetailResp(
      {this.cCUSTCD,
      this.cPOCD,
      this.iTOTAL,
      this.dSUCCDT,
      this.dCANDT,
      this.iCREDTERM,
      this.iCREDLIM,
      this.iPAID,
      this.iPOTOTAL});

  GetStoreDetailResp.fromJson(Map<String, dynamic> json) {
    cCUSTCD = json['cCUSTCD'];
    cPOCD = json['cPOCD'];
    iTOTAL = json['iTOTAL'];
    dSUCCDT = json['dSUCCDT'];
    dCANDT = json['dCANDT'];
    iCREDTERM = json['iCREDTERM'];
    iCREDLIM = json['iCREDLIM'];
    iPAID = json['iPAID'];
    iPOTOTAL = json['iPOTOTAL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cCUSTCD'] = this.cCUSTCD;
    data['cPOCD'] = this.cPOCD;
    data['iTOTAL'] = this.iTOTAL;
    data['dSUCCDT'] = this.dSUCCDT;
    data['dCANDT'] = this.dCANDT;
    data['iCREDTERM'] = this.iCREDTERM;
    data['iCREDLIM'] = this.iCREDLIM;
    data['iPAID'] = this.iPAID;
    data['iPOTOTAL'] = this.iPOTOTAL;
    return data;
  }
}