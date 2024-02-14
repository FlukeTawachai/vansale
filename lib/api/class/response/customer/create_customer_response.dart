class CreateCustomerResponse {
  bool success;
  String message;
  String customerID;

  CreateCustomerResponse({this.success, this.message, this.customerID});

  CreateCustomerResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    customerID = json['customerID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['customerID'] = this.customerID;
    return data;
  }
}
