import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../state_holders/bottom_nav_bar_controller.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        backToHome;
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
            title: const Text("WishList"),
            leading: IconButton(
              onPressed:backToHome,
              icon: const Icon(Icons.arrow_back_ios_outlined),
            )),
        body: GridView.builder(
            itemCount: 20,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.7,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8),
            itemBuilder: (context, index) {
              return null;
            
              // return const FittedBox(child: ProductCard());
            }),
      ),
    );
  }

  void backToHome() {
    Get.find<BottomNavBarController>().backToHome();
  }
}
