// ignore_for_file: prefer_collection_literals

class ProductModel {
  String? status;
  String? message;
  List<Products>? products;

  ProductModel({this.status, this.message, this.products});

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  String? title;
  String? image;
  List<String>? images;
  int? price;
  String? description;
  String? brand;
  String? model;
  String? color;
  String? category;
  int? discount;
  bool? popular;
  bool? onSale;

  Products({
    this.id,
    this.title,
    this.image,
    this.images,
    this.price,
    this.description,
    this.brand,
    this.model,
    this.color,
    this.category,
    this.discount,
    this.popular,
    this.onSale,
  });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    price = json['price'];
    description = json['description'];
    brand = json['brand'];
    model = json['model'];
    color = json['color'];
    category = json['category'];
    discount = json['discount'];
    popular = json['popular'];
    onSale = json['onSale'];
    // Handle both single image and multiple images
    if (json['images'] != null) {
      images = List<String>.from(json['images']);
    } else if (image != null) {
      images = [image!];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['images'] = images;
    data['price'] = price;
    data['description'] = description;
    data['brand'] = brand;
    data['model'] = model;
    data['color'] = color;
    data['category'] = category;
    data['discount'] = discount;
    data['popular'] = popular;
    data['onSale'] = onSale;
    return data;
  }
}
