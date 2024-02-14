class DeleteRequest {
  String? id;
  String? deleteUser;

  DeleteRequest({this.id, this.deleteUser});

  DeleteRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deleteUser = json['deleteUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['deleteUser'] = this.deleteUser;
    return data;
  }
}
