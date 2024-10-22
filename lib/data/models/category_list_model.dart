import 'package:crafty_boy_ecommerce_app/data/models/category_model.dart';

class CategoryListModel {
  String? msg;
  List<CategoryModel>? categoryList;

  CategoryListModel({this.msg, this.categoryList});

  CategoryListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      categoryList = <CategoryModel>[];
      json['data'].forEach((v) {
        categoryList!.add(CategoryModel.fromJson(v));
      });
    }
  }


}


