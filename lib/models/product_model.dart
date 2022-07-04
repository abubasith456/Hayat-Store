class ProductModel {
  int? count;
  List<Product>? product;
  String? error;

  ProductModel.error(this.error);

  ProductModel({this.count, this.product});

  ProductModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['products'] != null) {
      product = <Product>[];
      json['products'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.product != null) {
      data['products'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String? productName;
  int? productPrice;
  String? productDescription;
  String? productImage;
  bool? productisLiked;
  String? sId;
  Request? request;

  Product(
      {this.productName,
      this.productPrice,
      this.productDescription,
      this.productImage,
      this.productisLiked,
      this.sId,
      this.request});

  Product.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    productPrice = json['productPrice'];
    productDescription = json['productDescription'];
    productImage = json['productImage'];
    productisLiked = json['productisLiked'];
    sId = json['_id'];
    request =
        json['request'] != null ? new Request.fromJson(json['request']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productName'] = this.productName;
    data['productPrice'] = this.productPrice;
    data['productDescription'] = this.productDescription;
    data['productImage'] = this.productImage;
    data['productisLiked'] = this.productisLiked;
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
