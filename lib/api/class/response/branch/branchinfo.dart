import 'package:vansale/api/class/response/customer/customer_info.dart';

class BranchInfo {
  String branchCode;
  String branchName;
  String shopName;
  String taxNo;
  Address address;
  String tel;
  String fax;
  Contact contact;
  String isPhoto;
  Photo photo;
  List<Provinces> provinces;
  String guid;
  String status;
  String createDate;
  String createBy;
  String updateDate;
  String updateBy;

  BranchInfo(
      {this.branchCode,
      this.branchName,
      this.shopName,
      this.taxNo,
      this.address,
      this.tel,
      this.fax,
      this.contact,
      this.isPhoto,
      this.photo,
      this.provinces,
      this.guid,
      this.status,
      this.createDate,
      this.createBy,
      this.updateDate,
      this.updateBy});

  BranchInfo.fromJson(Map<String, dynamic> json) {
    branchCode = json['branchCode'];
    branchName = json['branchName'];
    shopName = json['shopName'];
    taxNo = json['taxNo'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    tel = json['tel'];
    fax = json['fax'];
    contact =
        json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
    isPhoto = json['isPhoto'];
    photo = json['photo'] != null ? new Photo.fromJson(json['photo']) : null;
    if (json['provinces'] != null) {
      provinces = <Provinces>[];
      json['provinces'].forEach((v) {
        provinces.add(new Provinces.fromJson(v));
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
    data['branchCode'] = this.branchCode;
    data['branchName'] = this.branchName;
    data['shopName'] = this.shopName;
    data['taxNo'] = this.taxNo;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['tel'] = this.tel;
    data['fax'] = this.fax;
    if (this.contact != null) {
      data['contact'] = this.contact.toJson();
    }
    data['isPhoto'] = this.isPhoto;
    if (this.photo != null) {
      data['photo'] = this.photo.toJson();
    }
    if (this.provinces != null) {
      data['provinces'] = this.provinces.map((v) => v.toJson()).toList();
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

class Provinces {
  String province;

  Provinces({this.province});

  Provinces.fromJson(Map<String, dynamic> json) {
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['province'] = this.province;
    return data;
  }
}
