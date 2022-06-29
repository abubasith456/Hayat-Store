class ProductModel {
  int? count;
  List<Products>? products;
  String? error;

  ProductModel.error(String error) {
    this.error = error;
  }

  ProductModel({this.count, this.products});

  ProductModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
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

class Products {
  String? name;
  int? price;
  String? description;
  String? category;
  String? productImage;
  String? sId;
  Request? request;

  Products(
      {this.name,
      this.price,
      this.description,
      this.category,
      this.productImage,
      this.sId,
      this.request});

  Products.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    description = json['description'];
    category = json['category'];
    productImage = json['productImage'];
    sId = json['_id'];
    request =
        json['request'] != null ? new Request.fromJson(json['request']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['category'] = this.category;
    data['productImage'] = this.productImage;
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
