class Urls {
  static const String _baseurl = "https://ecommerce-api.codesilicon.com/api";
  static const String dummyUrl = "$_baseurl/login";
  static const String sliderListUrl = "$_baseurl/ListProductSlider";
  static const String categoryListUrl = "$_baseurl/CategoryList";

  static String productListByRemark(String remark) => "$_baseurl/ListProductByRemark/$remark";
  static String productListByCategory(int categoryId) => "$_baseurl/ListProductByCategory/$categoryId";
  static String productDetailsById(int productId) => "$_baseurl/ProductDetailsById/$productId";
}
