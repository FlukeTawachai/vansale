class RouteInfo {
  String? routeCode;
  String? routeName;
  String? groupCode;
  String? branch;
  String? branchName;
  String? type;
  double? wage;
  double? cost;
  String? unit;
  String? guid;
  String? status;
  String? createDate;
  String? createBy;
  String? updateDate;
  String? updateBy;

  RouteInfo(
      {this.routeCode,
      this.routeName,
      this.groupCode,
      this.branch,
      this.branchName,
      this.type,
      this.wage,
      this.cost,
      this.unit,
      this.guid,
      this.status,
      this.createDate,
      this.createBy,
      this.updateDate,
      this.updateBy});

  RouteInfo.fromJson(Map<String, dynamic> json) {
    routeCode = json['routeCode'];
    routeName = json['routeName'];
    groupCode = json['groupCode'];
    branch = json['branch'];
    branchName = json['branchName'];
    type = json['type'];
    wage = json['wage'];
    cost = json['cost'];
    unit = json['unit'];
    guid = json['guid'];
    status = json['status'];
    createDate = json['createDate'];
    createBy = json['createBy'];
    updateDate = json['updateDate'];
    updateBy = json['updateBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['routeCode'] = this.routeCode;
    data['routeName'] = this.routeName;
    data['groupCode'] = this.groupCode;
    data['branch'] = this.branch;
    data['branchName'] = this.branchName;
    data['type'] = this.type;
    data['wage'] = this.wage;
    data['cost'] = this.cost;
    data['unit'] = this.unit;
    data['guid'] = this.guid;
    data['status'] = this.status;
    data['createDate'] = this.createDate;
    data['createBy'] = this.createBy;
    data['updateDate'] = this.updateDate;
    data['updateBy'] = this.updateBy;
    return data;
  }
}
