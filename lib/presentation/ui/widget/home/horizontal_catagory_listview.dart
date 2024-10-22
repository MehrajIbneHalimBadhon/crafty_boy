import 'package:flutter/material.dart';
import '../../../../data/models/category_model.dart';
import '../catagory_card.dart';

class HorizontalCatagoryListView extends StatelessWidget {
  const HorizontalCatagoryListView({
    super.key, required this.categoryList,
  });

  final List<CategoryModel> categoryList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: categoryList.length,
      itemBuilder: (context, index) {
        return  CatagoryCard(categoryModel: categoryList[index],);
      },
      separatorBuilder: (_, __) => const SizedBox(
        width: 8,
      ),
    );
  }
}

