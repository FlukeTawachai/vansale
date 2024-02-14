class GetProductReturnReq {
  String cBRANCD;
  String dCREADT;

  GetProductReturnReq({this.cBRANCD, this.dCREADT});

  GetProductReturnReq.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    dCREADT = json['dCREADT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['dCREADT'] = this.dCREADT;
    return data;
  }
}