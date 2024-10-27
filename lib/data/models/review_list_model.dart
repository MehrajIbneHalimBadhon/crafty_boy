
import 'package:crafty_boy_ecommerce_app/data/models/review_model.dart';

class ReviewListModel {
  String? msg;
  List<ReviewModel>? reviewList;

  ReviewListModel({this.msg, this.reviewList});

  ReviewListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      reviewList = <ReviewModel>[];
      json['data'].forEach((v) {
        reviewList!.add(ReviewModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (reviewList != null) {
      data['data'] = reviewList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}