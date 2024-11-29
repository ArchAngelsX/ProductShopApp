class Menu {
  String? name;
  String? description;
  int? price;
  String? imgPath;
  double? rating;

  Menu({
    this.name, 
    this.description, 
    this.price, 
    this.imgPath, 
    this.rating
    });

  Menu.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    price = json['price'];
    imgPath = json['img_path'];
    rating = json['rating'];
  }

Map<String, dynamic> toJson() => {
  'name': name,
  'description': description,
  'price': price,
  'img_path': imgPath,
  'rating': rating,
};
}