class SearchRefuelReq {
  String? cBRANCD;
  String? cVEHICD;
  String? dINVENTDT;

  SearchRefuelReq({this.cBRANCD, this.cVEHICD, this.dINVENTDT});

  SearchRefuelReq.fromJson(Map<String, dynamic> json) {
    cBRANCD = json['cBRANCD'];
    cVEHICD = json['cVEHICD'];
    dINVENTDT = json['dINVENT_DT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBRANCD'] = this.cBRANCD;
    data['cVEHICD'] = this.cVEHICD;
    data['dINVENT_DT'] = this.dINVENTDT;
    return data;
  }
}