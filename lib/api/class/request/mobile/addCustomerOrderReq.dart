class AddCustomerOrderReq {
  String? cCUSTCD;
  List<APRODUCT>? aPRODUCT;
  String? cCREABY;

  AddCustomerOrderReq({this.cCUSTCD, this.aPRODUCT, this.cCREABY});

  AddCustomerOrderReq.fromJson(Map<String, dynamic> json) {
    cCUSTCD = json['cCUSTCD'];
    if (json['aPRODUCT'] != null) {
      aPRODUCT = <APRODUCT>[];
      json['aPRODUCT'].forEach((v) {
        aPRODUCT!.add(new APRODUCT.fromJson(v));
      });
    }
    cCREABY = json['cCREABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cCUSTCD'] = this.cCUSTCD;
    if (this.aPRODUCT != null) {
      data['aPRODUCT'] = this.aPRODUCT!.map((v) => v.toJson()).toList();
    }
    data['cCREABY'] = this.cCREABY;
    return data;
  }
}

class APRODUCT {
  String? cPRODCD;
  double? iSSIZEQTY;
  double? iMSIZEQTY;
  double? iLSIZEQTY;

  APRODUCT({this.cPRODCD, this.iSSIZEQTY, this.iMSIZEQTY, this.iLSIZEQTY});

  APRODUCT.fromJson(Map<String, dynamic> json) {
    cPRODCD = json['cPRODCD'];
    iSSIZEQTY = json['iSSIZEQTY'];
    iMSIZEQTY = json['iMSIZEQTY'];
    iLSIZEQTY = json['iLSIZEQTY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cPRODCD'] = this.cPRODCD;
    data['iSSIZEQTY'] = this.iSSIZEQTY;
    data['iMSIZEQTY'] = this.iMSIZEQTY;
    data['iLSIZEQTY'] = this.iLSIZEQTY;
    return data;
  }
}