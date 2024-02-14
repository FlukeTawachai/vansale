class ConfigInfo {
  String configValues;
  String configValuesName;

  ConfigInfo({this.configValues, this.configValuesName});

  ConfigInfo.fromJson(Map<String, dynamic> json) {
    configValues = json['configValues'];
    configValuesName = json['configValuesName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['configValues'] = this.configValues;
    data['configValuesName'] = this.configValuesName;
    return data;
  }
}
