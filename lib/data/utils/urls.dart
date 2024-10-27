class Urls {
  static const String _baseurl = "https://ecommerce-api.codesilicon.com/api";
  static const String dummyUrl = "$_baseurl/login";
  static const String sliderListUrl = "$_baseurl/ListProductSlider";
  static const String categoryListUrl = "$_baseurl/CategoryList";
  static const String readProfile = "$_baseurl/ReadProfile";
  static const String addToCart = "$_baseurl/CreateCartList";
  static const String createProfile = "$_baseurl/CreateProfile";

  static const String createProductReviewUrl = '$_baseurl/CreateProductReview';
  static const String logoutUrl = '$_baseurl/logout';
  static const String productWishListUrl = '$_baseurl/ProductWishList';
  static const String cartListUrl = '$_baseurl/CartList';

  static String productListByRemark(String remark) =>
      "$_baseurl/ListProductByRemark/$remark";

  static String productListByCategory(int categoryId) =>
      "$_baseurl/ListProductByCategory/$categoryId";

  static String productDetailsById(int productId) =>
      "$_baseurl/ProductDetailsById/$productId";

  static String verifyEmail(String email) => "$_baseurl/UserLogin/$email";

  static String verifyOTP(String email, String otp) =>
      "$_baseurl/VerifyLogin/$email/$otp";

  static String getReviewList({required int productId}) =>
      '$_baseurl/ListReviewByProduct/$productId';

  static String removeWishListUrl({required int productId}) =>
      '$_baseurl/RemoveWishList/$productId';

  static String createWishListUrl({required int productId}) =>
      '$_baseurl/CreateWishList/$productId';
}
