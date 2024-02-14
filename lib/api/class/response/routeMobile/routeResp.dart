class RouteResp {
  String cGUID;
  String cRTECD;
  String cRTENM;
  String cGRPCD;
  String iCOST;
  String cTYPE;
  String cBRANCD;
  String iWAGE;
  String cUNIT;
  String cSTATUS;
  String dCREADT;
  String cCREABY;
  String dUPDADT;
  String cUPDABY;

  RouteResp(
      {this.cGUID,
      this.cRTECD,
      this.cRTENM,
      this.cGRPCD,
      this.iCOST,
      this.cTYPE,
      this.cBRANCD,
      this.iWAGE,
      this.cUNIT,
      this.cSTATUS,
      this.dCREADT,
      this.cCREABY,
      this.dUPDADT,
      this.cUPDABY});

  RouteResp.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
    cRTECD = json['cRTECD'];
    cRTENM = json['cRTENM'];
    cGRPCD = json['cGRPCD'];
    iCOST = json['iCOST'];
    cTYPE = json['cTYPE'];
    cBRANCD = json['cBRANCD'];
    iWAGE = json['iWAGE'];
    cUNIT = json['cUNIT'];
    cSTATUS = json['cSTATUS'];
    dCREADT = json['dCREADT'];
    cCREABY = json['cCREABY'];
    dUPDADT = json['dUPDADT'];
    cUPDABY = json['cUPDABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    data['cRTECD'] = this.cRTECD;
    data['cRTENM'] = this.cRTENM;
    data['cGRPCD'] = this.cGRPCD;
    data['iCOST'] = this.iCOST;
    data['cTYPE'] = this.cTYPE;
    data['cBRANCD'] = this.cBRANCD;
    data['iWAGE'] = this.iWAGE;
    data['cUNIT'] = this.cUNIT;
    data['cSTATUS'] = this.cSTATUS;
    data['dCREADT'] = this.dCREADT;
    data['cCREABY'] = this.cCREABY;
    data['dUPDADT'] = this.dUPDADT;
    data['cUPDABY'] = this.cUPDABY;
    return data;
  }
}