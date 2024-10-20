import 'package:e_commerce/pages/cart/cart_page.dart';
import 'package:e_commerce/pages/food/popular_food_detail.dart';
import 'package:e_commerce/pages/food/recommended_food_detail.dart';
import 'package:e_commerce/pages/home/home_page.dart';
import 'package:e_commerce/pages/home/main_food_page.dart';
import 'package:e_commerce/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String spalshPage = "/splash-page";

  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSplashPage() => '$spalshPage';

  static List<GetPage> routes = [
    GetPage(name: spalshPage, page: () => SplashScreen()),
    GetPage(
      name: initial,
      page: () {
        print("main food page get called");
        return HomePage();
      },
      // transition: Transition.fadeIn
    ),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        print("popular food get called");
        return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      // transition: Transition.fadeIn,
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        print("recommended food get called");
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      // transition: Transition.fadeIn,
    ),
    GetPage(
      name: cartPage,
      page: () {
        return CartPage();
      },
      // transition: Transition.fadeIn
    )
  ];
}
