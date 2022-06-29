final String CartData = 'mycart';

class CartFields {
  static final List<String> values = [
    /// Add all fields
    id, name, price, description, categoryId, productImage, productId
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String price = 'price';
  static final String description = 'description';
  static final String categoryId = 'categoryId';
  static final String productImage = 'productImage';
  static final String productId = 'productId';
}

class Cart {
  final int? id;
  final String name;
  final String price;
  final String description;
  final String categoryId;
  final String productImage;
  final String productId;

  const Cart({
    this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.categoryId,
    required this.productImage,
    required this.productId,
  });

  Cart copy({
    int? id,
    String? name,
    String? price,
    String? description,
    String? categoryId,
    String? productImage,
    String? productId,
  }) =>
      Cart(
          id: id ?? this.id,
          name: name ?? this.name,
          price: price ?? this.price,
          description: description ?? this.description,
          categoryId: categoryId ?? this.categoryId,
          productImage: productImage ?? this.productImage,
          productId: productId ?? this.productId);

  static Cart fromJson(Map<String, Object?> json) => Cart(
      id: json[CartFields.id] as int?,
      name: json[CartFields.name] as String,
      price: json[CartFields.price] as String,
      description: json[CartFields.description] as String,
      categoryId: json[CartFields.categoryId] as String,
      productImage: json[CartFields.productImage] as String,
      productId: json[CartFields.productId] as String);

  Map<String, Object?> toJson() => {
        CartFields.id: id,
        CartFields.name: name,
        CartFields.price: price,
        CartFields.description: description,
        CartFields.categoryId: categoryId,
        CartFields.productImage: productImage,
        CartFields.productId: productId,
      };
}
