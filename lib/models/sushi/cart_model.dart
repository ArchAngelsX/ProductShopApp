class CartModel {
  String? name;
  int? price;
  String? imgPath;
  int? quantity;

  CartModel({
    this.name, 
    this.price, 
    this.imgPath, 
    this.quantity
    });

  CartModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    imgPath = json['img_path'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    data['img_path'] = imgPath;
    data['quantity'] = quantity;
    return data;
  }
}