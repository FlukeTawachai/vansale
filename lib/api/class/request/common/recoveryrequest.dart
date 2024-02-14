class RecoveryRequest {
  String? id;
  String? recoveryUser;

  RecoveryRequest({this.id, this.recoveryUser});

  RecoveryRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    recoveryUser = json['recoveryUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['recoveryUser'] = this.recoveryUser;
    return data;
  }
}
