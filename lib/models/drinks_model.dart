class DrinksModel {
  int? count;
  List<DrinksProduct>? drinksProduct;
  String? error;

  DrinksModel.error(String error) {
    this.error = error;
  }

  DrinksModel({this.count, this.drinksProduct});

  DrinksModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['drinksProduct'] != null) {
      drinksProduct = <DrinksProduct>[];
      json['drinksProduct'].forEach((v) {
        drinksProduct!.add(new DrinksProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.drinksProduct != null) {
      data['drinksProduct'] =
          this.drinksProduct!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DrinksProduct {
  String? name;
  int? price;
  String? description;
  String? drinksImage;
  String? sId;
  Request? request;

  DrinksProduct(
      {this.name,
      this.price,
      this.description,
      this.drinksImage,
      this.sId,
      this.request});

  DrinksProduct.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    description = json['description'];
    drinksImage = json['drinksImage'];
    sId = json['_id'];
    request =
        json['request'] != null ? new Request.fromJson(json['request']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['drinksImage'] = this.drinksImage;
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
