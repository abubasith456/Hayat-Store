class GroceryModel {
  int? count;
  List<GroceryProduct>? groceryProduct;
  String? error;

  GroceryModel.error(String error) {
    this.error = error;
  }

  GroceryModel({this.count, this.groceryProduct});

  GroceryModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['groceryProduct'] != null) {
      groceryProduct = <GroceryProduct>[];
      json['groceryProduct'].forEach((v) {
        groceryProduct!.add(new GroceryProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.groceryProduct != null) {
      data['groceryProduct'] =
          this.groceryProduct!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroceryProduct {
  String? name;
  int? price;
  String? description;
  String? groceryImage;
  String? sId;
  Request? request;

  GroceryProduct(
      {this.name,
      this.price,
      this.description,
      this.groceryImage,
      this.sId,
      this.request});

  GroceryProduct.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    description = json['description'];
    groceryImage = json['groceryImage'];
    sId = json['_id'];
    request =
        json['request'] != null ? new Request.fromJson(json['request']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['groceryImage'] = this.groceryImage;
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
