import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String image;
  String name;
  String id, categoryId;
  bool isFavourite;
  double price;
  String description;
  String status;

  int? quantity;

  ProductModel({
    required this.image,
    required this.name,
    required this.status,
    required this.id,
    required this.categoryId,
    required this.isFavourite,
    required this.price,
    required this.description,
    this.quantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        image: json["image"],
        name: json["name"],
        status: json["status"],
        id: json["id"].toString(),
        isFavourite: false,
        price: double.parse(json["price"].toString()),
        description: json["description"],
        quantity: json["quantity"],
        categoryId: json["categoryId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "name": name,
        "id": id,
        "status": status,
        "isFavourite": isFavourite,
        "price": price,
        "description": description,
        "quantity": quantity,
        "categoryId": categoryId
      };

  ProductModel copyWith({
    String? name,
    String? image,
    String? id,
    String? categoryId,
    String? description,
    String? price,
    String? status,
  }) =>
      ProductModel(
        name: name ?? this.name,
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        description: description ?? this.description,
        isFavourite: false,
        price: price != null ? double.parse(price) : this.price,
        status: status ?? this.status,
        image: image ?? this.image,
        quantity: 1,
      );
}
