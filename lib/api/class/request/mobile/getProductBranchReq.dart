class GetProductBranchReq {
  String cBRANCD;
  String cCUSTTYPE;
  String cPRICECD;
  String cPRODCD;
  String cPRODNM;

  GetProductBranchReq(
      {this.cBRANCD,
      this.cCUSTTYPE,
      this.cPRICECD,
      this.cPRODCD,
      this.cPRODNM});

  GetProductBranchReq.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cCUSTTYPE = json['cCUSTTYPE'];
    cPRICECD = json['cPRICECD'];
    cPRODCD = json['cPRODCD'];
    cPRODNM = json['cPRODNM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['cCUSTTYPE'] = this.cCUSTTYPE;
    data['cPRICECD'] = this.cPRICECD;
    data['cPRODCD'] = this.cPRODCD;
    data['cPRODNM'] = this.cPRODNM;
    return data;
  }
}