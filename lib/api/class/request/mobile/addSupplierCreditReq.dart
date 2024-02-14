class AddSupplierCreditReq {
  String? cSUPPCD;
  String? cSUPPNM;
  String? cREFDOC;
  String? cBRANCD;
  String? cBRANNM;
  String? cPRODCD;
  String? cPRODNM;
  String? cSUOMCD;
  String? cSUOMNM;
  String? cMUOMCD;
  String? cMUOMNM;
  String? cLUOMCD;
  String? cLUOMNM;
  String? iSUNITPRICE;
  String? iMUNITPRICE;
  String? iLUNITPRICE;
  String? iORQTY;
  String? iDEBIT;
  String? iCREDIT;
  String? iRCQTY;
  String? cCREABY;

  AddSupplierCreditReq(
      {this.cSUPPCD,
      this.cSUPPNM,
      this.cREFDOC,
      this.cBRANCD,
      this.cBRANNM,
      this.cPRODCD,
      this.cPRODNM,
      this.cSUOMCD,
      this.cSUOMNM,
      this.cMUOMCD,
      this.cMUOMNM,
      this.cLUOMCD,
      this.cLUOMNM,
      this.iSUNITPRICE,
      this.iMUNITPRICE,
      this.iLUNITPRICE,
      this.iORQTY,
      this.iDEBIT,
      this.iCREDIT,
      this.iRCQTY,
      this.cCREABY});

  AddSupplierCreditReq.fromJson(Map<String, dynamic> json) {
    cSUPPCD = json['cSUPPCD'];
    cSUPPNM = json['cSUPPNM'];
    cREFDOC = json['cREFDOC'];
    cBRANCD = json['cBRANCD'];
    cBRANNM = json['cBRANNM'];
    cPRODCD = json['cPRODCD'];
    cPRODNM = json['cPRODNM'];
    cSUOMCD = json['cSUOMCD'];
    cSUOMNM = json['cSUOMNM'];
    cMUOMCD = json['cMUOMCD'];
    cMUOMNM = json['cMUOMNM'];
    cLUOMCD = json['cLUOMCD'];
    cLUOMNM = json['cLUOMNM'];
    iSUNITPRICE = json['iSUNITPRICE'];
    iMUNITPRICE = json['iMUNITPRICE'];
    iLUNITPRICE = json['iLUNITPRICE'];
    iORQTY = json['iORQTY'];
    iDEBIT = json['iDEBIT'];
    iCREDIT = json['iCREDIT'];
    iRCQTY = json['iRCQTY'];
    cCREABY = json['cCREABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cSUPPCD'] = this.cSUPPCD;
    data['cSUPPNM'] = this.cSUPPNM;
    data['cREFDOC'] = this.cREFDOC;
    data['cBRANCD'] = this.cBRANCD;
    data['cBRANNM'] = this.cBRANNM;
    data['cPRODCD'] = this.cPRODCD;
    data['cPRODNM'] = this.cPRODNM;
    data['cSUOMCD'] = this.cSUOMCD;
    data['cSUOMNM'] = this.cSUOMNM;
    data['cMUOMCD'] = this.cMUOMCD;
    data['cMUOMNM'] = this.cMUOMNM;
    data['cLUOMCD'] = this.cLUOMCD;
    data['cLUOMNM'] = this.cLUOMNM;
    data['iSUNITPRICE'] = this.iSUNITPRICE;
    data['iMUNITPRICE'] = this.iMUNITPRICE;
    data['iLUNITPRICE'] = this.iLUNITPRICE;
    data['iORQTY'] = this.iORQTY;
    data['iDEBIT'] = this.iDEBIT;
    data['iCREDIT'] = this.iCREDIT;
    data['iRCQTY'] = this.iRCQTY;
    data['cCREABY'] = this.cCREABY;
    return data;
  }
}