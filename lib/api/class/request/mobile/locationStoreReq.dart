class LocationStoreReq {
  String cCUSTCD;

  LocationStoreReq({this.cCUSTCD});

  LocationStoreReq.fromJson(Map<String, dynamic> json) {
    cCUSTCD = json['cCUSTCD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cCUSTCD'] = this.cCUSTCD;
    return data;
  }
}