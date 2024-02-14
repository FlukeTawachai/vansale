class AddProductTransferReq {
  String? cBRANCD;
  String? cCREABY;
  String? cTPYE;
  String? cSENDER;
  String? cSENDERNM;
  String? cRECEIVER;
  String? cRECEIVERNM;
  List<PRODUCTLIST>? aPRODUCT;

  AddProductTransferReq(
      {this.cBRANCD,
      this.cCREABY,
      this.cTPYE,
      this.cSENDER,
      this.cSENDERNM,
      this.cRECEIVER,
      this.cRECEIVERNM,
      this.aPRODUCT});

  AddProductTransferReq.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cCREABY = json['cCREABY'];
    cTPYE = json['cTPYE'];
    cSENDER = json['cSENDER'];
    cSENDERNM = json['cSENDERNM'];
    cRECEIVER = json['cRECEIVER'];
    cRECEIVERNM = json['cRECEIVERNM'];
    if (json['aPRODUCT'] != null) {
      aPRODUCT = <PRODUCTLIST>[];
      json['aPRODUCT'].forEach((v) {
        aPRODUCT!.add(new PRODUCTLIST.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['cCREABY'] = this.cCREABY;
    data['cTPYE'] = this.cTPYE;
    data['cSENDER'] = this.cSENDER;
    data['cSENDERNM'] = this.cSENDERNM;
    data['cRECEIVER'] = this.cRECEIVER;
    data['cRECEIVERNM'] = this.cRECEIVERNM;
    if (this.aPRODUCT != null) {
      data['aPRODUCT'] = this.aPRODUCT!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PRODUCTLIST {
  String? cSETCD;
  String? cSETNM;
  String? cPRODCD;
  String? cSIZE;
  double? iQTY;
  double? iUOMPRICE;

  PRODUCTLIST(
      {this.cSETCD,
      this.cSETNM,
      this.cPRODCD,
      this.cSIZE,
      this.iQTY,
      this.iUOMPRICE});

  PRODUCTLIST.fromJson(Map<String, dynamic> json) {
    cSETCD = json['cSETCD'];
    cSETNM = json['cSETNM'];
    cPRODCD = json['cPRODCD'];
    cSIZE = json['cSIZE'];
    iQTY = json['iQTY'];
    iUOMPRICE = json['iUOMPRICE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cSETCD'] = this.cSETCD;
    data['cSETNM'] = this.cSETNM;
    data['cPRODCD'] = this.cPRODCD;
    data['cSIZE'] = this.cSIZE;
    data['iQTY'] = this.iQTY;
    data['iUOMPRICE'] = this.iUOMPRICE;
    return data;
  }
}