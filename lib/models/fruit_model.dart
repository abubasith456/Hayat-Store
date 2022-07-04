class FruitsModel {
  int? count;
  List<Fruitproduct>? fruitproduct;
  String? error;

  FruitsModel.error(this.error);
  FruitsModel({this.count, this.fruitproduct});

  FruitsModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['fruitproduct'] != null) {
      fruitproduct = <Fruitproduct>[];
      json['fruitproduct'].forEach((v) {
        fruitproduct!.add(new Fruitproduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.fruitproduct != null) {
      data['fruitproduct'] = this.fruitproduct!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Fruitproduct {
  String? name;
  int? price;
  String? description;
  String? fruitImage;
  String? sId;
  Request? request;

  Fruitproduct(
      {this.name,
      this.price,
      this.description,
      this.fruitImage,
      this.sId,
      this.request});

  Fruitproduct.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    description = json['description'];
    fruitImage = json['fruitImage'];
    sId = json['_id'];
    request =
        json['request'] != null ? new Request.fromJson(json['request']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['fruitImage'] = this.fruitImage;
    data['_id'] = this.sId;
    if (this.request != null) {
      data['request'] = this.request!.toJson();
    }
    return data;
  }
}

class Request {
  String? type;
  String? url;

  Request({this.type, this.url});

  Request.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}
