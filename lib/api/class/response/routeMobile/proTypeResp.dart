class ProTypeResp {
  bool? onClick;
  String? typeName;
  String? typeCD;
  List<Category>? category;

  ProTypeResp({this.onClick, this.typeName, this.typeCD, this.category});

  ProTypeResp.fromJson(Map<String, dynamic> json) {
    onClick = json['onClick'];
    typeName = json['typeName'];
    typeCD = json['typeCD'];
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category?.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['onClick'] = this.onClick;
    data['typeName'] = this.typeName;
    data['typeCD'] = this.typeCD;
    if (this.category != null) {
      data['category'] = this.category?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? catNM;
  String? catCD;
  bool? onSelect;
  int? hight;
  List<SubCategory>? subCategory;

  Category(
      {this.catNM, this.catCD, this.onSelect, this.hight, this.subCategory});

  Category.fromJson(Map<String, dynamic> json) {
    catNM = json['catNM'];
    catCD = json['catCD'];
    onSelect = json['onSelect'];
    hight = json['hight'];
    if (json['subCategory'] != null) {
      subCategory = <SubCategory>[];
      json['subCategory'].forEach((v) {
        subCategory?.add(new SubCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['catNM'] = this.catNM;
    data['catCD'] = this.catCD;
    data['onSelect'] = this.onSelect;
    data['hight'] = this.hight;
    if (this.subCategory != null) {
      data['subCategory'] = this.subCategory?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategory {
  bool? click;
  String? subCatNM;
  String? subCatCD;
  List<Brand>? brand;

  SubCategory({this.click, this.subCatNM, this.subCatCD, this.brand});

  SubCategory.fromJson(Map<String, dynamic> json) {
    click = json['click'];
    subCatNM = json['subCatNM'];
    subCatCD = json['subCatCD'];
    if (json['brand'] != null) {
      brand = <Brand>[];
      json['brand'].forEach((v) {
        brand?.add(new Brand.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['click'] = this.click;
    data['subCatNM'] = this.subCatNM;
    data['subCatCD'] = this.subCatCD;
    if (this.brand != null) {
      data['brand'] = this.brand?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Brand {
  bool? click;
  String? brandNM;
  String? brandCD;

  Brand({this.click, this.brandNM, this.brandCD});

  Brand.fromJson(Map<String, dynamic> json) {
    click = json['click'];
    brandNM = json['brandNM'];
    brandCD = json['brandCD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['click'] = this.click;
    data['brandNM'] = this.brandNM;
    data['brandCD'] = this.brandCD;
    return data;
  }
}
