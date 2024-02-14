class GetProductStockReq {
  String cBRANCD;
  String cWH;
  String cPRODCD;

  GetProductStockReq({this.cBRANCD, this.cWH, this.cPRODCD});

  GetProductStockReq.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cWH = json['cWH'];
    cPRODCD = json['cPRODCD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['cWH'] = this.cWH;
    data['cPRODCD'] = this.cPRODCD;
    return data;
  }
}