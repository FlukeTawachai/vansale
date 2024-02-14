class CustomerRequest {
  String? status;
  String? updateUser;
  String? customerID;
  String? customerName;
  String? branchCode;
  String? customerBranchName;
  String? taxNo;
  String? telNo;
  String? contactName;
  String? contactTel;
  double? distancs;
  String? line;
  String? type;
  String? payType;
  int? creditTerm;
  double? creditLimit;
  String? saleTableCode;
  String? isBasket;
  String? isPhoto;
  Photo? photo;
  Address? address;
  String? asset;
  List<RouteRequest>? routes;
  String? autoPO;

  CustomerRequest(
      {this.status,
      this.updateUser,
      this.customerID,
      this.customerName,
      this.branchCode,
      this.customerBranchName,
      this.taxNo,
      this.telNo,
      this.contactName,
      this.contactTel,
      this.distancs,
      this.line,
      this.type,
      this.payType,
      this.creditTerm,
      this.creditLimit,
      this.saleTableCode,
      this.isBasket,
      this.isPhoto,
      this.photo,
      this.address,
      this.asset,
      this.routes,
      this.autoPO});

  CustomerRequest.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    updateUser = json['updateUser'];
    customerID = json['customerID'];
    customerName = json['customerName'];
    branchCode = json['branchCode'];
    customerBranchName = json['customerBranchName'];
    taxNo = json['taxNo'];
    telNo = json['telNo'];
    contactName = json['contactName'];
    contactTel = json['contactTel'];
    distancs = json['distancs'];
    line = json['line'];
    type = json['type'];
    payType = json['payType'];
    creditTerm = json['creditTerm'];
    creditLimit = json['creditLimit'];
    saleTableCode = json['saleTableCode'];
    isBasket = json['isBasket'];
    isPhoto = json['isPhoto'];
    photo = json['photo'] != null ? new Photo.fromJson(json['photo']) : null;
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    asset = json['asset'];
    if (json['routes'] != null) {
      routes = <RouteRequest>[];
      json['routes'].forEach((v) {
        routes!.add(new RouteRequest.fromJson(v));
      });
    }
    autoPO = json['autoPO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['updateUser'] = this.updateUser;
    data['customerID'] = this.customerID;
    data['customerName'] = this.customerName;
    data['branchCode'] = this.branchCode;
    data['customerBranchName'] = this.customerBranchName;
    data['taxNo'] = this.taxNo;
    data['telNo'] = this.telNo;
    data['contactName'] = this.contactName;
    data['contactTel'] = this.contactTel;
    data['distancs'] = this.distancs;
    data['line'] = this.line;
    data['type'] = this.type;
    data['payType'] = this.payType;
    data['creditTerm'] = this.creditTerm;
    data['creditLimit'] = this.creditLimit;
    data['saleTableCode'] = this.saleTableCode;
    data['isBasket'] = this.isBasket;
    data['isPhoto'] = this.isPhoto;
    if (this.photo != null) {
      data['photo'] = this.photo!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['asset'] = this.asset;
    if (this.routes != null) {
      data['routes'] = this.routes!.map((v) => v.toJson()).toList();
    }
    data['autoPO'] = this.autoPO;
    return data;
  }
}

class Photo {
  String? server;
  String? path;
  String? name;

  Photo({this.server, this.path, this.name});

  Photo.fromJson(Map<String, dynamic> json) {
    server = json['server'];
    path = json['path'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['server'] = this.server;
    data['path'] = this.path;
    data['name'] = this.name;
    return data;
  }
}

class Address {
  String? shipTo;
  String? location;
  String? postCode;
  String? province;
  String? district;
  String? subDistrict;
  String? address;
  String? latitude;
  String? longtitude;

  Address(
      {this.shipTo,
      this.location,
      this.postCode,
      this.province,
      this.district,
      this.subDistrict,
      this.address,
      this.latitude,
      this.longtitude});

  Address.fromJson(Map<String, dynamic> json) {
    shipTo = json['shipTo'];
    location = json['location'];
    postCode = json['postCode'];
    province = json['province'];
    district = json['district'];
    subDistrict = json['subDistrict'];
    address = json['address'];
    latitude = json['latitude'];
    longtitude = json['longtitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shipTo'] = this.shipTo;
    data['location'] = this.location;
    data['postCode'] = this.postCode;
    data['province'] = this.province;
    data['district'] = this.district;
    data['subDistrict'] = this.subDistrict;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longtitude'] = this.longtitude;
    return data;
  }
}

class RouteRequest {
  String? groupCode;
  String? routeCode;
  String? auto;

  RouteRequest({this.groupCode, this.routeCode, this.auto});

  RouteRequest.fromJson(Map<String, dynamic> json) {
    groupCode = json['groupCode'];
    routeCode = json['routeCode'];
    auto = json['auto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupCode'] = this.groupCode;
    data['routeCode'] = this.routeCode;
    data['auto'] = this.auto;
    return data;
  }
}
