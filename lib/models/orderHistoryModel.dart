class OrderHistoryModel {
  String? status;
  String? sId;
  int? uniqueId;
  int? numOfItems;
  int? userId;
  String? userName;
  int? amount;
  String? address;
  List<Products>? products;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? error;

  OrderHistoryModel(
      {this.status,
      this.sId,
      this.uniqueId,
      this.numOfItems,
      this.userId,
      this.userName,
      this.amount,
      this.address,
      this.products,
      this.createdAt,
      this.updatedAt,
      this.iV});

  OrderHistoryModel.error(this.error);

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sId = json['_id'];
    uniqueId = json['unique_id'];
    numOfItems = json['numOfItems'];
    userId = json['user_id'];
    userName = json['user_name'];
    amount = json['amount'];
    address = json['address'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['unique_id'] = this.uniqueId;
    data['numOfItems'] = this.numOfItems;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['amount'] = this.amount;
    data['address'] = this.address;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Products {
  String? sId;
  String? productId;
  String? productName;
  String? productImage;
  String? quantity;

  Products(
      {this.sId,
      this.productId,
      this.productName,
      this.productImage,
      this.quantity});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productId = json['productId'];
    productName = json['productName'];
    productImage = json['productImage'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['productImage'] = this.productImage;
    data['quantity'] = this.quantity;
    return data;
  }
}
