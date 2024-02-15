class OrderBranchFields {
  static final List<String> values = [
    /// Add all fields
    id, date, branchName, amount
  ];

  static final String id = 'id';
  static final String date = 'date';
  static final String branchName = 'branchName';
  static final String amount = 'amount';
}

class OrderBranchModel {
  final int? id;
  final String? date;
  final String? branchName;
  final double? amount;

  OrderBranchModel({this.id, this.date, this.branchName, this.amount});

  OrderBranchModel.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        date = res["date"],
        branchName = res["branchName"],
        amount = res["amount"];

  static orderBranchfromJson(Map<String, Object> json) => OrderBranchModel(
        id: json[OrderBranchFields.id] as int,
        date: json[OrderBranchFields.date] as String,
        branchName: json[OrderBranchFields.branchName] as String,
        amount: json[OrderBranchFields.amount] as double,
      );

  Map<String, Object> toMap() {
    return {
      'id': id!,
      'date': date!,
      'branchName': branchName!,
      'amount': amount!,
    };
  }
}
