class Constants {
  // Base URL
  // static String appBaseUrl = "http://127.0.0.1:8000";
  static String appBaseUrl = "https://food.hariomshop.com";

  // Get Pouplar Products
  static String popularProductsUrl = "/api/v1/products/popular";

  // Get Recommended Products
  static String recommendedProductsUrl = "/api/v1/products/recommended";

  // Get Drink Products
  static String drinkProductsUrl = "/api/v1/products/drinks";

  // Token
  static String token = "";

  // Register Users URL
  static String registerUsersUrl = "/api/v1/auth/register";

  // Register Users URL
  static String loginUsersUrl = "/api/v1/auth/login";

  // Email token
  static String email = "";

  // Password token
  static String password = "";

  // User Info URL
  static String userInfo = "/api/v1/customer/info";

  // GeoCode URL
  static String geoCodeUrl = '/api/v1/config/geocode-api';

  // User Address
  static String userAddress = 'user_address';

  // Add user address
  static String addUserAddress = '/api/v1/customer/address/add';

  // Get user address
  static String getUserAddressList = '/api/v1/customer/address/list';
}
