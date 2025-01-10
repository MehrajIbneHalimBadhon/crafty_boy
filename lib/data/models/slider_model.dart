class SliderModel {
  int? _id;
  String? _title;
  String? _shortDes;
  String? _price;
  String? _image;
  int? _productId;
  String? _createdAt;
  String? _updatedAt;

  SliderModel(
      {int? id,
      String? title,
      String? shortDes,
      String? price,
      String? image,
      int? productId,
      String? createdAt,
      String? updatedAt}) {
    if (id != null) {
      _id = id;
    }
    if (title != null) {
      _title = title;
    }
    if (shortDes != null) {
      _shortDes = shortDes;
    }
    if (price != null) {
      _price = price;
    }
    if (image != null) {
      _image = image;
    }
    if (productId != null) {
      _productId = productId;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get shortDes => _shortDes;
  set shortDes(String? shortDes) => _shortDes = shortDes;
  String? get price => _price;
  set price(String? price) => _price = price;
  String? get image => _image;
  set image(String? image) => _image = image;
  int? get productId => _productId;
  set productId(int? productId) => _productId = productId;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  SliderModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _shortDes = json['short_des'];
    _price = json['price'];
    _image = json['image'];
    _productId = json['product_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
}
