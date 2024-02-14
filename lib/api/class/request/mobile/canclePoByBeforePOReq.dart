class CanclePoByBeforePOReq {
  String? cCUSTCD;
  String? cGRPCD;
  String? cUPDABY;

  CanclePoByBeforePOReq({this.cCUSTCD, this.cGRPCD, this.cUPDABY});

  CanclePoByBeforePOReq.fromJson(Map<String, dynamic> json) {
    cCUSTCD = json['cCUSTCD'];
    cGRPCD = json['cGRPCD'];
    cUPDABY = json['cUPDABY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cCUSTCD'] = this.cCUSTCD;
    data['cGRPCD'] = this.cGRPCD;
    data['cUPDABY'] = this.cUPDABY;
    return data;
  }
}