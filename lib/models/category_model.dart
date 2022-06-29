class CategoryModel {
  String? sId;
  String? name;
  String? icon;
  String? color;
  int? iV;
  String? error;

  CategoryModel.error(String error) {
    this.error = error;
  }

  CategoryModel({this.sId, this.name, this.icon, this.color, this.iV});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    icon = json['icon'];
    color = json['color'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['color'] = this.color;
    data['__v'] = this.iV;
    return data;
  }
}
