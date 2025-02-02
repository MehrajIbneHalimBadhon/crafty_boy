class ReviewProfileDataModel {
  int? id;
  String? cusName;

  ReviewProfileDataModel({this.id, this.cusName});

  ReviewProfileDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cusName = json['cus_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cus_name'] = cusName;
    return data;
  }
}
