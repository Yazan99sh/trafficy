// ignore_for_file: constant_identifier_names

class Urls {
  static const String APPWRITE_ENDPOINT =
      'https://9189-81-92-202-22.ngrok.io/v1';
  static const String APPWRITE_PROJECTID = '61a5cebea8348';
  static const String DOMAIN = 'http://138.197.186.138';
  static const String BASE_API = DOMAIN + '';
  static const String IMAGES_ROOT = DOMAIN + '/upload/';
  static const UPLOAD_API = BASE_API + '/uploadfile';
  static const SIGN_UP_API = BASE_API + '/clientregister';
  static const OWNER_PROFILE_API = BASE_API + '/userprofile';
  static const CREATE_TOKEN_API = BASE_API + '/login_check';
  static const REPORT_API = BASE_API + '/report';
  static const NOTIFICATION_API = BASE_API + '/notificationtoken';
  static const COMPANYINFO_API = BASE_API + '/companyinfoforuser';
  static const NOTIFICATIONNEWCHAT_API = BASE_API + '/notificationnewchat';
  static const NOTIFICATIONTOADMIN_API = BASE_API + '/notificationtoadmin';
  static const GET_TOP_PRODUCTS_API = BASE_API + '/productstopwanted';
  static const GET_STORE_CATEGORIES_API = BASE_API + '/storecategories';
  static const GET_STORE_CATEGORY_LIST_API =
      BASE_API + '/storeownerbycategoryid/';
  static const GET_MOST_WANTED_STORE_PRODUCTS =
      BASE_API + '/productstopwantedofspecificstoreowner';
  static const GET_PRODUCTS_CATEGORY_API = BASE_API + '/storeProductsCategory';
  static const GET_PRODUCTS_BY_CATEGORY_API =
      BASE_API + '/productsbycategoryidandstoreownerprofileid';
  static const GET_BEST_STORES_API = BASE_API + '/storeOwnerBest';
  static const GET_STORE_PROFILE = BASE_API + '/storeownerprofilebyid/';
  static const GET_MY_ORDERS = BASE_API + '/ordersbyclientid';
  static const GET_MY_NOTIFICATION = BASE_API + '/notificationsLocal';
  static const GET_ORDER_LOGS = BASE_API + '/orderLogs';
  static const GET_ORDER_DETAILS = BASE_API + '/orderstatusbyordernumber';
  static const POST_CLIENT_ORDER_API = BASE_API + '/clientorder';
  static const POST_CLIENT_SEND_IT_ORDER_API = BASE_API + '/clientsendorder';
  static const POST_CLIENT_PRIVATE_ORDER_API = BASE_API + '/clientSpecialOrder';
  static const DELETE_CLIENT_ORDER_API = BASE_API + '/ordercancel';
  static const UPDATE_CLIENT_ORDER_API = BASE_API + '/orderUpdatebyclient';
  static const UPDATE_SPECIAL_CLIENT_ORDER_API =
      BASE_API + '/orderSpecialUpdateByClient';
  static const UPDATE_SEND_CLIENT_ORDER_API =
      BASE_API + '/orderSendUpdateByClient';
  static const GET_PROFILE_API = BASE_API + '/clientProfile';
  static const POST_PROFILE_API = BASE_API + '/clientprofile';
  static const CHECK_USER_ROLE = BASE_API + '/checkUserType';
  static const GET_SEARCH_RESULT = BASE_API + '/clientFilter/';
  static const RATE_STORE = BASE_API + '/ratingStoreByClient';
  static const RATE_PRODUCT = BASE_API + '/ratingProductByClient';

  static const RATE_CAPTAIN = BASE_API + '/ratingCaptainByClient';
  static const GET_SUBCATEGORIES_API =
      BASE_API + '/subcategoriesbystorecategoryid/';
  static const GET_PRODUCTS_BY_CATEGORIES =
      BASE_API + '/productsbystoreproductcategoryid/';
  static const GET_PRODUCTS_BY_SUBCATEGORIES =
      BASE_API + '/storeproductscategoryleveltwowithproducts/';
  static const GET_PRODUCTS_BY_MAIN_CATEGORIES =
      BASE_API + '/productsbystorecategory/';
  static const GET_PRODUCT_DETAILS_API = BASE_API + '/product';
}
