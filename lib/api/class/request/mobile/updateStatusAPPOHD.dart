class UpdateStatusAPPOHDReq {
  String cPOCD;
  String cCREABY;

  UpdateStatusAPPOHDReq({this.cPOCD, this.cCREABY});

  UpdateStatusAPPOHDReq.fromJson(Map<String, dynamic> json) {
    cPOCD = json['cPOCD'];
    cCREABY = json['cCREABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cPOCD'] = this.cPOCD;
    data['cCREABY'] = this.cCREABY;
    return data;
  }
}