final String LikedData = 'myLiked';

class LikedFields {
  static final List<String> values = [
    /// Add all fields
    id, name, price, description, productImage, productId, isLiked
  ];

  static final String id = '_id';
  static final String name = 'name';
  static final String price = 'price';
  static final String description = 'description';
  static final String productImage = 'productImage';
  static final String productId = 'productId';
  static final String isLiked = 'isLiked';
}

class Liked {
  final int? id;
  final String name;
  final String price;
  final String description;
  final String productImage;
  final String productId;
  final String isLiked;

  const Liked({
    this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.productImage,
    required this.productId,
    required this.isLiked,
  });

  Liked copy({
    int? id,
    String? name,
    String? price,
    String? description,
    String? productImage,
    String? productId,
    String? isLiked,
  }) =>
      Liked(
          id: id ?? this.id,
          name: name ?? this.name,
          price: price ?? this.price,
          description: description ?? this.description,
          productImage: productImage ?? this.productImage,
          productId: productId ?? this.productId,
          isLiked: isLiked ?? this.isLiked);

  static Liked fromJson(Map<String, Object?> json) => Liked(
      id: json[LikedFields.id] as int?,
      name: json[LikedFields.name] as String,
      price: json[LikedFields.price] as String,
      description: json[LikedFields.description] as String,
      productImage: json[LikedFields.productImage] as String,
      productId: json[LikedFields.productId] as String,
      isLiked: json[LikedFields.isLiked] as String);

  Map<String, Object?> toJson() => {
        LikedFields.id: id,
        LikedFields.name: name,
        LikedFields.price: price,
        LikedFields.description: description,
        LikedFields.productImage: productImage,
        LikedFields.productId: productId,
        LikedFields.isLiked: isLiked,
      };
}
