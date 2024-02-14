class GetRefuelReq {
  String? cGUID;

  GetRefuelReq({this.cGUID});

  GetRefuelReq.fromJson(Map<String, dynamic> json) {
    cGUID = json['cGUID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cGUID'] = this.cGUID;
    return data;
  }
}