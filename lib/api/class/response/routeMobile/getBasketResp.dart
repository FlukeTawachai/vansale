class GetBasketResp {
  String? cGUID;
  String? cBASKCD;
  String? cBASKNM;
  String? iPRICE;
  String? cPHOTOSERV;
  String? cPHOTOPATH;
  String? cPHOTONM;
  String? cSTATUS;
  String? dCREADT;
  String? cCREABY;
  String? dUPDADT;
  String? cUPDABY;
  bool? cCheck;
  bool? cICUK;
  bool? cDCUL;

  GetBasketResp(
      {this.cGUID,
      this.cBASKCD,
      this.cBASKNM,
      this.iPRICE,
      this.cPHOTOSERV,
      this.cPHOTOPATH,
      this.cPHOTONM,
      this.cSTATUS,
      this.dCREADT,
      this.cCREABY,
      this.dUPDADT,
      this.cUPDABY,
      this.cCheck,
      this.cICUK,
      this.cDCUL});

  GetBasketResp.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
    cBASKCD = json['cBASKCD'];
    cBASKNM = json['cBASKNM'];
    iPRICE = json['iPRICE'];
    cPHOTOSERV = json['cPHOTO_SERV'];
    cPHOTOPATH = json['cPHOTO_PATH'];
    cPHOTONM = json['cPHOTO_NM'];
    cSTATUS = json['cSTATUS'];
    dCREADT = json['dCREADT'];
    cCREABY = json['cCREABY'];
    dUPDADT = json['dUPDADT'];
    cUPDABY = json['cUPDABY'];
    cCheck = json['cCheck'];
    cICUK = json['cICUK'];
    cDCUL = json['cDCUL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    data['cBASKCD'] = this.cBASKCD;
    data['cBASKNM'] = this.cBASKNM;
    data['iPRICE'] = this.iPRICE;
    data['cPHOTO_SERV'] = this.cPHOTOSERV;
    data['cPHOTO_PATH'] = this.cPHOTOPATH;
    data['cPHOTO_NM'] = this.cPHOTONM;
    data['cSTATUS'] = this.cSTATUS;
    data['dCREADT'] = this.dCREADT;
    data['cCREABY'] = this.cCREABY;
    data['dUPDADT'] = this.dUPDADT;
    data['cUPDABY'] = this.cUPDABY;
    data['cCheck'] = this.cCheck;
    data['cICUK'] = this.cICUK;
    data['cDCUL'] = this.cDCUL;
    return data;
  }
}
