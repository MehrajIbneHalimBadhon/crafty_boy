import 'package:flutter/material.dart';
import '../catagory_card.dart';

class HorizontalCatagoryListView extends StatelessWidget {
  const HorizontalCatagoryListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, index) {
        return const CatagoryCard();
      },
      separatorBuilder: (_, __) => const SizedBox(
        width: 8,
      ),
    );
  }
}

