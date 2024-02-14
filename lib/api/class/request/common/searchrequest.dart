class SearchRequest {
  int? start;
  int? length;
  List<Searches>? searches;
  List<Sorts>? sorts;

  SearchRequest({this.start, this.length, this.searches, this.sorts});

  SearchRequest.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    length = json['length'];
    if (json['searches'] != null) {
      searches = <Searches>[];
      json['searches'].forEach((v) {
        searches!.add(new Searches.fromJson(v));
      });
    }
    if (json['sorts'] != null) {
      sorts = <Sorts>[];
      json['sorts'].forEach((v) {
        sorts!.add(new Sorts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['length'] = this.length;
    if (this.searches != null) {
      data['searches'] = this.searches!.map((v) => v.toJson()).toList();
    }
    if (this.sorts != null) {
      data['sorts'] = this.sorts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Searches {
  String? columnName;
  String? condition;
  String? value;
  String? type;
  String? operator;

  Searches(
      {this.columnName, this.condition, this.value, this.type, this.operator});

  Searches.fromJson(Map<String, dynamic> json) {
    columnName = json['columnName'];
    condition = json['condition'];
    value = json['value'];
    type = json['type'];
    operator = json['operator'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['columnName'] = this.columnName;
    data['condition'] = this.condition;
    data['value'] = this.value;
    data['type'] = this.type;
    data['operator'] = this.operator;
    return data;
  }
}

class Sorts {
  String? columnName;
  String? direction;

  Sorts({this.columnName, this.direction});

  Sorts.fromJson(Map<String, dynamic> json) {
    columnName = json['columnName'];
    direction = json['direction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['columnName'] = this.columnName;
    data['direction'] = this.direction;
    return data;
  }
}
