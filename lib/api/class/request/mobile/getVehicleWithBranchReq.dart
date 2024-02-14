class GetVehicleWithBranchReq {
  String? cBRANCD;
  String? cCUSTTYPE;
  String? cPRICECD;

  GetVehicleWithBranchReq({this.cBRANCD, this.cCUSTTYPE, this.cPRICECD});

  GetVehicleWithBranchReq.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cCUSTTYPE = json['cCUSTTYPE'];
    cPRICECD = json['cPRICECD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['cCUSTTYPE'] = this.cCUSTTYPE;
    data['cPRICECD'] = this.cPRICECD;
    return data;
  }
}