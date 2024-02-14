class GetSupplierBasketResp {
  String? cGUID;
  String? cSUPCD;
  String? cBASKCD;
  int? iSEQ;
  String? iCOST;
  String? cSTATUS;
  String? dCREADT;
  String? cCREABY;
  String? dUPDADT;
  String? cUPDABY;
  String? cBASKNM;
  String? iPRICE;
  String? cPHOTOSERV;
  String? cPHOTOPATH;
  String? cPHOTONM;

  GetSupplierBasketResp(
      {this.cGUID,
      this.cSUPCD,
      this.cBASKCD,
      this.iSEQ,
      this.iCOST,
      this.cSTATUS,
      this.dCREADT,
      this.cCREABY,
      this.dUPDADT,
      this.cUPDABY,
      this.cBASKNM,
      this.iPRICE,
      this.cPHOTOSERV,
      this.cPHOTOPATH,
      this.cPHOTONM});

  GetSupplierBasketResp.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
    cSUPCD = json['cSUPCD'];
    cBASKCD = json['cBASKCD'];
    iSEQ = json['iSEQ'];
    iCOST = json['iCOST'];
    cSTATUS = json['cSTATUS'];
    dCREADT = json['dCREADT'];
    cCREABY = json['cCREABY'];
    dUPDADT = json['dUPDADT'];
    cUPDABY = json['cUPDABY'];
    cBASKNM = json['cBASKNM'];
    iPRICE = json['iPRICE'];
    cPHOTOSERV = json['cPHOTO_SERV'];
    cPHOTOPATH = json['cPHOTO_PATH'];
    cPHOTONM = json['cPHOTO_NM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    data['cSUPCD'] = this.cSUPCD;
    data['cBASKCD'] = this.cBASKCD;
    data['iSEQ'] = this.iSEQ;
    data['iCOST'] = this.iCOST;
    data['cSTATUS'] = this.cSTATUS;
    data['dCREADT'] = this.dCREADT;
    data['cCREABY'] = this.cCREABY;
    data['dUPDADT'] = this.dUPDADT;
    data['cUPDABY'] = this.cUPDABY;
    data['cBASKNM'] = this.cBASKNM;
    data['iPRICE'] = this.iPRICE;
    data['cPHOTO_SERV'] = this.cPHOTOSERV;
    data['cPHOTO_PATH'] = this.cPHOTOPATH;
    data['cPHOTO_NM'] = this.cPHOTONM;
    return data;
  }
}
