class CustomerInfo {
  String? customerID;
  String? customerName;
  String? branchCode;
  String? branchName;
  String? customerBranchName;
  String? taxNo;
  String? telNo;
  Contact? contact;
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
  List<Routes>? routes;
  String? guid;
  String? status;
  String? createDate;
  String? createBy;
  String? updateDate;
  String? updateBy;

  CustomerInfo(
      {this.customerID,
      this.customerName,
      this.branchCode,
      this.branchName,
      this.customerBranchName,
      this.taxNo,
      this.telNo,
      this.contact,
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
      this.guid,
      this.status,
      this.createDate,
      this.createBy,
      this.updateDate,
      this.updateBy});

  CustomerInfo.fromJson(Map<String, dynamic> json) {
    customerID = json['customerID'];
    customerName = json['customerName'];
    branchCode = json['branchCode'];
    branchName = json['branchName'];
    customerBranchName = json['customerBranchName'];
    taxNo = json['taxNo'];
    telNo = json['telNo'];
    contact =
        json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
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
      routes = <Routes>[];
      json['routes'].forEach((v) {
        routes!.add(new Routes.fromJson(v));
      });
    }
    guid = json['guid'];
    status = json['status'];
    createDate = json['createDate'];
    createBy = json['createBy'];
    updateDate = json['updateDate'];
    updateBy = json['updateBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerID'] = this.customerID;
    data['customerName'] = this.customerName;
    data['branchCode'] = this.branchCode;
    data['branchName'] = this.branchName;
    data['customerBranchName'] = this.customerBranchName;
    data['taxNo'] = this.taxNo;
    data['telNo'] = this.telNo;
    if (this.contact != null) {
      data['contact'] = this.contact!.toJson();
    }
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
    data['guid'] = this.guid;
    data['status'] = this.status;
    data['createDate'] = this.createDate;
    data['createBy'] = this.createBy;
    data['updateDate'] = this.updateDate;
    data['updateBy'] = this.updateBy;
    return data;
  }
}

class Contact {
  String? name;
  String? tel;

  Contact({this.name, this.tel});

  Contact.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    tel = json['tel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['tel'] = this.tel;
    return data;
  }
}

class Photo {
  String? serverName;
  String? path;
  String? name;
  String? url;

  Photo({this.serverName, this.path, this.name, this.url});

  Photo.fromJson(Map<String, dynamic> json) {
    serverName = json['serverName'];
    path = json['path'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serverName'] = this.serverName;
    data['path'] = this.path;
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class Address {
  String? latitude;
  String? longtitude;
  String? shipTo;
  String? postCode;
  String? province;
  String? district;
  String? subDistrict;
  String? address;
  String? location;

  Address(
      {this.latitude,
      this.longtitude,
      this.shipTo,
      this.postCode,
      this.province,
      this.district,
      this.subDistrict,
      this.address,
      this.location});

  Address.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longtitude = json['longtitude'];
    shipTo = json['shipTo'];
    postCode = json['postCode'];
    province = json['province'];
    district = json['district'];
    subDistrict = json['subDistrict'];
    address = json['address'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude ?? '';
    data['longtitude'] = this.longtitude ?? '';
    data['shipTo'] = this.shipTo;
    data['postCode'] = this.postCode;
    data['province'] = this.province;
    data['district'] = this.district;
    data['subDistrict'] = this.subDistrict;
    data['address'] = this.address;
    data['location'] = this.location;
    return data;
  }
}

class Routes {
  String? groupCode;
  String? routeCode;

  Routes({this.groupCode, this.routeCode});

  Routes.fromJson(Map<String, dynamic> json) {
    groupCode = json['groupCode'];
    routeCode = json['routeCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupCode'] = this.groupCode;
    data['routeCode'] = this.routeCode;
    return data;
  }
}
