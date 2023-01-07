class OrdersNewModel {
  int? uniqueId;
  int? numOfItems;
  int? userId;
  String? userName;
  int? amount;
  String? address;
  String? status;
  List<Products>? products;
  String? error;

  OrdersNewModel.error(String errorMessage) {
    this.error = errorMessage;
  }

  OrdersNewModel(
      {this.uniqueId,
      this.numOfItems,
      this.amount,
      this.userId,
      this.userName,
      this.address,
      this.status,
      this.products});

  OrdersNewModel.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'];
    numOfItems = json['numOfItems'];
    userId = json['user_id'];
    userName = json['user_name'];
    amount = json['amount'];
    address = json['address'];
    status = json['status'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unique_id'] = this.uniqueId;
    data['numOfItems'] = this.numOfItems;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['amount'] = this.amount;
    data['address'] = this.address;
    data['status'] = this.status;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? productId;
  String? productName;
  String? productImage;
  String? quantity;

  Products(
      {this.productId, this.productName, this.productImage, this.quantity});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    productImage = json['productImage'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['productImage'] = this.productImage;
    data['quantity'] = this.quantity;
    return data;
  }
}
