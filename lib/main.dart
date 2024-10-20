import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/controllers/popular_product_controller.dart';
import 'package:e_commerce/controllers/recommended_product_controller.dart';
import 'package:e_commerce/data/api/api_client.dart';
import 'package:e_commerce/data/repository/cart_repo.dart';
import 'package:e_commerce/data/repository/popular_product_repo.dart';
import 'package:e_commerce/data/repository/recommended_product_repo.dart';
import 'package:e_commerce/pages/cart/cart_page.dart';
import 'package:e_commerce/pages/food/popular_food_detail.dart';
import 'package:e_commerce/pages/food/recommended_food_detail.dart';
import 'package:e_commerce/pages/home/food_page_body.dart';

import 'package:e_commerce/pages/home/main_food_page.dart';
import 'package:e_commerce/pages/splash/splash_page.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  // Get.put<SharedPreferences>(Get.find());
  // Get.put<ApiClient>(ApiClient(appBaseUrl: "http://mvs.bslmeiyu.com"));
  // Get.put<PopularProductRepo>(PopularProductRepo(apiClient: Get.find()));
  // Get.put<RecommendedProductRepo>(
  //     RecommendedProductRepo(apiClient: Get.find()));
  // Get.put<CartRepo>(CartRepo(sharedPreferences: Get.find()));

  // Get.put<PopularProductController>(
  //   PopularProductController(
  //     popularProductRepo: Get.find<PopularProductRepo>(),
  //   ),
  // );

  // Get.put<RecommendedProductController>(
  //   RecommendedProductController(
  //     recommendedProductRepo: Get.find<RecommendedProductRepo>(),
  //   ),
  // );
  // Get.put<CartController>(
  //   CartController(
  //     cartRepo: Get.find<CartRepo>(),
  //   ),
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(context.height.toString());
    print("width is " + context.width.toString());
    //here we need to use getmaterialapp instead of material app
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Cheify',
          // home: SplashScreen(),
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
        );
      });
    });
  }
}
