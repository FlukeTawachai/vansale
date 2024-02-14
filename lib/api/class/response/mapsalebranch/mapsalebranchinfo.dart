class MapBranchSaleInfo {
  String priceSelected;
  String priceCode;
  String priceName;

  MapBranchSaleInfo({this.priceSelected, this.priceCode, this.priceName});

  MapBranchSaleInfo.fromJson(Map<String, dynamic> json) {
    priceSelected = json['priceSelected'];
    priceCode = json['priceCode'];
    priceName = json['priceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['priceSelected'] = this.priceSelected;
    data['priceCode'] = this.priceCode;
    data['priceName'] = this.priceName;
    return data;
  }
}
