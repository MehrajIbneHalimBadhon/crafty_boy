import 'package:crafty_boy_ecommerce_app/presentation/ui/screens/review_post_screen.dart';
import 'package:crafty_boy_ecommerce_app/presentation/ui/widget/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../state_holders/auth_controller.dart';
import '../../state_holders/review_controller.dart';
import 'email_verification_screen.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key, required this.productId});

  final int productId;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ReviewController>().getProductReview(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GetBuilder<ReviewController>(builder: (reviewController) {
          if (reviewController.inProgress) {
            return const CenteredCircularProgressIndicator();
          }
          if (reviewController.reviewList.isEmpty) {
            return Center(
              child: Text(
                'No review yet!',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            );
          }
          return _buildReviewListView(reviewController);
        }),
      ),
      floatingActionButton: SizedBox(
          height: 70,
          width: 150,
          child: ElevatedButton(
              onPressed: () {
                bool checkIsLoggedInUser =
                    Get.find<AuthController>().isLoggedInUser();
                if (checkIsLoggedInUser) {
                  Get.to(() => ReviewPostScreen(
                        productId: widget.productId,
                      ));
                } else {
                  Get.to(() => const EmailVerificationScreen());
                }
              },
              child: const Text('Add review'))),
    );
  }

  Widget _buildReviewListView(ReviewController reviewController) {
    return ListView.builder(
        itemCount: reviewController.reviewList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Card(
              elevation: 4,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey.shade300),
                            child: const Icon(
                              Icons.person_outline,
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            reviewController
                                    .reviewList[index].profile!.cusName ??
                                "No Name",
                            style: Theme.of(context).textTheme.titleMedium,
                          )
                        ],
                      ),
                    ),
                    Text(
                      reviewController.reviewList[index].description ?? '',
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
