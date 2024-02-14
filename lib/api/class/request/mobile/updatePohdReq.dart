class UpdatePohdReq {
  String cPOCD;
  String cPREPAIRCFSTATUS;
  double iBASKETTOTAL;

  UpdatePohdReq({this.cPOCD, this.cPREPAIRCFSTATUS, this.iBASKETTOTAL});

  UpdatePohdReq.fromJson(Map<String, dynamic> json) {
    cPOCD = json['cPOCD'];
    cPREPAIRCFSTATUS = json['cPREPAIRCFSTATUS'];
    iBASKETTOTAL = json['iBASKETTOTAL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cPOCD'] = this.cPOCD;
    data['cPREPAIRCFSTATUS'] = this.cPREPAIRCFSTATUS;
    data['iBASKETTOTAL'] = this.iBASKETTOTAL;
    return data;
  }
}