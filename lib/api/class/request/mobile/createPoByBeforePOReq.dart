class CreatePoByBeforePOReq {
  String? cCUSTCD;
  String? cGRPCD;
  String? cCREABY;

  CreatePoByBeforePOReq({this.cCUSTCD, this.cGRPCD, this.cCREABY});

  CreatePoByBeforePOReq.fromJson(Map<String, dynamic> json) {
    cCUSTCD = json['cCUSTCD'];
    cGRPCD = json['cGRPCD'];
    cCREABY = json['cCREABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cCUSTCD'] = this.cCUSTCD;
    data['cGRPCD'] = this.cGRPCD;
    data['cCREABY'] = this.cCREABY;
    return data;
  }
}