class AddProductIncreateCounterReq {
  String? cBRANCD;
  String? cCUSTTYPE;
  String? cCUSTCD;
  String? cGRPCD;
  String? iQTY;
  String? cREFDOC;
  List<String>? aINCPRO;
  String? cCREABY;

  AddProductIncreateCounterReq(
      {this.cBRANCD,
      this.cCUSTTYPE,
      this.cCUSTCD,
      this.cGRPCD,
      this.iQTY,
      this.cREFDOC,
      this.aINCPRO,
      this.cCREABY});

  AddProductIncreateCounterReq.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cCUSTTYPE = json['cCUSTTYPE'];
    cCUSTCD = json['cCUSTCD'];
    cGRPCD = json['cGRPCD'];
    iQTY = json['iQTY'];
    cREFDOC = json['cREFDOC'];
    aINCPRO = json['aINCPRO'].cast<String>();
    cCREABY = json['cCREABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['cCUSTTYPE'] = this.cCUSTTYPE;
    data['cCUSTCD'] = this.cCUSTCD;
    data['cGRPCD'] = this.cGRPCD;
    data['iQTY'] = this.iQTY;
    data['cREFDOC'] = this.cREFDOC;
    data['aINCPRO'] = this.aINCPRO;
    data['cCREABY'] = this.cCREABY;
    return data;
  }
}