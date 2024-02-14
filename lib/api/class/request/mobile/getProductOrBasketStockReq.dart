class GetProductOrBasketStockReq {
  String? cBRANCD;
  String? cWH;
  String? cSEARCH;

  GetProductOrBasketStockReq({this.cBRANCD, this.cWH, this.cSEARCH});

  GetProductOrBasketStockReq.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cWH = json['cWH'];
    cSEARCH = json['cSEARCH'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['cWH'] = this.cWH;
    data['cSEARCH'] = this.cSEARCH;
    return data;
  }
}