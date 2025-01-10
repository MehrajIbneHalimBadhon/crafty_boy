
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../state_holders/review_post_controller.dart';
import '../utils/tost_message.dart';
import '../widgets/loding_indicator.dart';

class ReviewPostScreen extends StatefulWidget {
  const ReviewPostScreen({super.key, required this.productId});
  final int productId;

  @override
  State<ReviewPostScreen> createState() => _ReviewPostScreenState();
}

class _ReviewPostScreenState extends State<ReviewPostScreen> {
  final ReviewPostController reviewPostController =
      Get.find<ReviewPostController>();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double _rating = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Review'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Make a new review!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 30),
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: TextFormField(
                  controller: _descriptionTEController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                      hintText: 'Write a review of the product'),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'You must write a review';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                  'Rating: ${_rating.toStringAsFixed(1)}'), // Display current rating
              const SizedBox(height: 5),
              Slider(
                max: 5,
                value: _rating,
                onChanged: (double value) {
                  setState(() {
                    _rating = value;
                  });
                },
              ),
              const SizedBox(height: 15),
              GetBuilder<ReviewPostController>(builder: (reviewPostController) {
                return Visibility(
                  visible: !reviewPostController.inProgress,
                  replacement: const LoadingIndicator(),
                  child: ElevatedButton(
                      onPressed: _onClickSubmitButton,
                      child: const Text('Submit Review')),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  void _onClickSubmitButton() async {
    bool isReviewSuccess = await reviewPostController.postProductReview(
        _descriptionTEController.text.trim(), widget.productId, _rating);
    if (isReviewSuccess) {
      _descriptionTEController.clear();
      _rating = 1.0;
      toastMessage(context, 'Review Added');
    } else {
      toastMessage(
          context,
          reviewPostController.errorMessage ??
              'Something went wrong! Try again.',
          true);
    }
  }

  @override
  void dispose() {
    _descriptionTEController.dispose();
    super.dispose();
  }
}
