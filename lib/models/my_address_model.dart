const myAddressTableName = "myAddress";

class MyAddressFields {
  static const String id = '_id';
  static const String userId = 'userId';
  static const String name = 'name';
  static const String mobileNumber = 'mobileNumber';
  static const String pinCode = 'pinCode';
  static const String address = 'address';
  static const String area = 'area';
  static const String landmark = "landmark";
  static const String alteMobNumber = "alteMobNumber";
}

class MyAddress {
  final int? id;
  final String userId;
  final String name;
  final String mobileNumber;
  final String pinCode;
  final String address;
  final String area;
  final String landmark;
  final String alteMobNumber;

  const MyAddress(
      {this.id,
      required this.userId,
      required this.name,
      required this.mobileNumber,
      required this.pinCode,
      required this.address,
      required this.area,
      required this.landmark,
      required this.alteMobNumber});

  MyAddress copy({
    int? id,
    String? name,
    String? userId,
    String? mobileNumber,
    String? pinCode,
    String? address,
    String? area,
    String? landmark,
    String? alteMobNumber,
  }) =>
      MyAddress(
          id: id ?? this.id,
          userId: userId ?? this.userId,
          name: name ?? this.name,
          mobileNumber: mobileNumber ?? this.mobileNumber,
          pinCode: pinCode ?? this.pinCode,
          address: address ?? this.address,
          area: area ?? this.area,
          landmark: landmark ?? this.landmark,
          alteMobNumber: alteMobNumber ?? this.alteMobNumber);

  static MyAddress fromJson(Map<String, Object?> json) => MyAddress(
      id: json[MyAddressFields.id] as int?,
      name: json[MyAddressFields.name] as String,
      userId: json[MyAddressFields.userId] as String,
      mobileNumber: json[MyAddressFields.mobileNumber] as String,
      pinCode: json[MyAddressFields.pinCode] as String,
      address: json[MyAddressFields.address] as String,
      area: json[MyAddressFields.area] as String,
      landmark: json[MyAddressFields.landmark] as String,
      alteMobNumber: json[MyAddressFields.alteMobNumber] as String);

  Map<String, Object?> toJson() => {
        MyAddressFields.id: id,
        MyAddressFields.name: name,
        MyAddressFields.userId: userId,
        MyAddressFields.mobileNumber: mobileNumber,
        MyAddressFields.pinCode: pinCode,
        MyAddressFields.address: address,
        MyAddressFields.area: area,
        MyAddressFields.landmark: landmark,
        MyAddressFields.alteMobNumber: alteMobNumber,
      };
}
