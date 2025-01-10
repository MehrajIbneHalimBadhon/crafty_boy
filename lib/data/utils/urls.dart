class Urls {
  static const String _baseUrl = 'https://ecommerce-api.codesilicon.com/api';

  static const String homeSliderListUrl = '$_baseUrl/ListProductSlider';
  static const String categoryListUrl = '$_baseUrl/CategoryList';
  static const String readUserProfileUrl = '$_baseUrl/ReadProfile';
  static const String addToCartUrl = '$_baseUrl/CreateCartList';
  static const String cartListUrl = '$_baseUrl/CartList';
  static String removeCartUrl(String productId) => '$_baseUrl/DeleteCartList/$productId';
  static const String createProfileUrl = '$_baseUrl/CreateProfile';
  static const String createProductReviewUrl = '$_baseUrl/CreateProductReview';
  static const String logoutUrl = '$_baseUrl/logout';
  static const String productWishListUrl = '$_baseUrl/ProductWishList';

  static String productListByRemark({required String remark}) =>
      '$_baseUrl/ListProductByRemark/$remark';

  static String categoryListById({required int categoryId}) =>
      '$_baseUrl/ListProductByCategory/$categoryId';

  static String productDetailsById({required int productId}) =>
      '$_baseUrl/ProductDetailsById/$productId';

  static String verifyUserLogin({required String email}) =>
      '$_baseUrl/UserLogin/$email';

  static String verifyOTP({required String email, required String otp}) =>
      '$_baseUrl/VerifyLogin/$email/$otp';
  static String getReviewList({required int productId}) =>
      '$_baseUrl/ListReviewByProduct/$productId';

  static String removeWishListUrl({required int productId}) =>
      '$_baseUrl/RemoveWishList/$productId';

  static String createWishListUrl({required int productId}) =>
      '$_baseUrl/CreateWishList/$productId';
}
