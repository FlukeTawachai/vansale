class RespEmpAuthen {
  String? userName;
  String? empName;
  String? hasPhoto;
  String? photoServer;
  String? photoPath;
  String? photoUrl;
  String? loginDateTime;

  RespEmpAuthen(
      {this.userName,
      this.empName,
      this.hasPhoto,
      this.photoServer,
      this.photoPath,
      this.photoUrl,
      this.loginDateTime});

  RespEmpAuthen.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    empName = json['empName'];
    hasPhoto = json['hasPhoto'];
    photoServer = json['photoServer'];
    photoPath = json['photoPath'];
    photoUrl = json['photoUrl'];
    loginDateTime = json['loginDateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['empName'] = this.empName;
    data['hasPhoto'] = this.hasPhoto;
    data['photoServer'] = this.photoServer;
    data['photoPath'] = this.photoPath;
    data['photoUrl'] = this.photoUrl;
    data['loginDateTime'] = this.loginDateTime;
    return data;
  }
}
