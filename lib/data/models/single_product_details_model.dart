
import 'package:crafty_boy_ecommerce_app/data/models/product_model.dart';

class SingleProductDetailsModel {
  int? id;
  String? img1;
  String? img2;
  String? img3;
  String? img4;
  String? des;
  String? color;
  String? size;
  int? productId;
  String? createdAt;
  String? updatedAt;
  ProductModel? product;

  SingleProductDetailsModel(
      {this.id,
      this.img1,
      this.img2,
      this.img3,
      this.img4,
      this.des,
      this.color,
      this.size,
      this.productId,
      this.createdAt,
      this.updatedAt,
      this.product});

  SingleProductDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img1 = json['img1'];
    img2 = json['img2'];
    img3 = json['img3'];
    img4 = json['img4'];
    des = json['des'];
    color = json['color'];
    size = json['size'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
  }
}
