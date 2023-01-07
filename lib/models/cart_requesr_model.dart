class OrderRequestModel {
  List<Product>? product;
  String? error;

  OrderRequestModel.error(this.error);

  OrderRequestModel({this.product});

  OrderRequestModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      product = <Product>[];
      json['products'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['products'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String? productId;
  String? productName;
  String? productImage;
  String? quantity;

  Product({
    required this.productName,
    required this.productId,
    required this.quantity,
    required this.productImage,
  });

  Product.fromJson(Map<dynamic, dynamic> json) {
    productName = json['productName'];
    productId = json['productId'];
    quantity = json['quantitiy'];
    productImage = json['productImage'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productName'] = this.productName;
    data['productId'] = this.productId;
    data['quantitiy'] = this.quantity;
    data['productImage'] = this.productImage;
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
