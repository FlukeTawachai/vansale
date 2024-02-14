class GetCustomerOfBranchReq {
  String cBRANCD;
  String cGRPCD;
  String cRTECD;
  String cVEHICD;

  GetCustomerOfBranchReq(
      {this.cBRANCD, this.cGRPCD, this.cRTECD, this.cVEHICD});

  GetCustomerOfBranchReq.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cGRPCD = json['cGRPCD'];
    cRTECD = json['cRTECD'];
    cVEHICD = json['cVEHICD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['cGRPCD'] = this.cGRPCD;
    data['cRTECD'] = this.cRTECD;
    data['cVEHICD'] = this.cVEHICD;
    return data;
  }
}