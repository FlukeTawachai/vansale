class UpdatePodtReq {
  String cPOCD;
  int iSEQ;
  String cPREPAIRSTATUS;
  double iPREPAIRAMOUT;

  UpdatePodtReq(
      {this.cPOCD, this.iSEQ, this.cPREPAIRSTATUS, this.iPREPAIRAMOUT});

  UpdatePodtReq.fromJson(Map<String, dynamic> json) {
    cPOCD = json['cPOCD'];
    iSEQ = json['iSEQ'];
    cPREPAIRSTATUS = json['cPREPAIRSTATUS'];
    iPREPAIRAMOUT = json['iPREPAIRAMOUT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cPOCD'] = this.cPOCD;
    data['iSEQ'] = this.iSEQ;
    data['cPREPAIRSTATUS'] = this.cPREPAIRSTATUS;
    data['iPREPAIRAMOUT'] = this.iPREPAIRAMOUT;
    return data;
  }
}