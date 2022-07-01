class VegetablesModel {
  int? count;
  List<VegetableProducts>? products;
  String? error;

  VegetablesModel.error(this.error);

  VegetablesModel({this.count, this.products});

  VegetablesModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['products'] != null) {
      products = <VegetableProducts>[];
      json['products'].forEach((v) {
        products!.add(new VegetableProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VegetableProducts {
  String? name;
  int? price;
  String? description;
  String? vegetableImage;
  String? sId;
  Request? request;

  VegetableProducts(
      {this.name,
      this.price,
      this.description,
      this.vegetableImage,
      this.sId,
      this.request});

  VegetableProducts.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    description = json['description'];
    vegetableImage = json['vegetableImage'];
    sId = json['_id'];
    request =
        json['request'] != null ? new Request.fromJson(json['request']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['vegetableImage'] = this.vegetableImage;
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
