import 'dart:async';

import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/data/repository/popular_product_repo.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/models/products_model.dart';
import 'package:e_commerce/presentation/colors.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/utils/durations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  //This is a private variable
  List<ProductModel> _popularProductList = [];
  //This is public variable
  List<ProductModel> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      // print("Got products of popular products");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      // print(_popularProductList);
      _isLoaded = true;
      update();
    } else {
      print("Could not get popular products");
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      // print("incremented to $quantity");
      _quantity = checkQuantity(_quantity + 1);
      // print("number of items " + _quantity.toString());
    } else {
      // print("Decremented to $quantity");
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar("Item count", "You can't reduce more !",
          backgroundColor: AppColors.errorColor,
          colorText: AppColors.mainTextColor,
          margin: EdgeInsets.only(top: Dimensions.height15),
          duration: Duration(seconds: AppDurations.snackbarDuration));
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    // if exists
    //get from storage _inCartItmes
    // print("exist or not " + exist.toString());
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
    // print("The quantity in the cart is " + _inCartItems.toString());
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      print("The id is " +
          value.id.toString() +
          " the quantity is " +
          value.quantity.toString());
    });

    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
