import 'package:e_commerce/data/repository/popular_product_repo.dart';
import 'package:e_commerce/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/recommended_product_repo.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  //This is a private variable
  List<ProductModel> _recommendedProductList = [];
  //This is public variable
  List<ProductModel> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      // print("Got products of recommended products");
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      // print(_recommendedProductList);
      _isLoaded = true;
      update();
    } else {
      print("Could not get recommended products");
    }
  }
}
