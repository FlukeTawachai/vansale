class SearchBasketReq {
  String? cBASKNM;
  String? cBASKCD;

  SearchBasketReq({this.cBASKNM, this.cBASKCD});

  SearchBasketReq.fromJson(Map<String, dynamic> json) {
    cBASKNM = json['cBASKNM'];
    cBASKCD = json['cBASKCD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBASKNM'] = this.cBASKNM;
    data['cBASKCD'] = this.cBASKCD;
    return data;
  }
}