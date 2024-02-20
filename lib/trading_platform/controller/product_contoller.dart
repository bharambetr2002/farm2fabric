import 'package:farm2fabric/consts/consts.dart';
import 'package:farm2fabric/trading_platform/models/category_model.dart';
import 'package:flutter/services.dart';

class ProductController extends GetxController {
  var subcat = [];
  var quantity = 0.obs;
  var totalPrice = 0.obs;

  getSubCategorys(title) async {
    subcat.clear();
    var data = await rootBundle
        .loadString("lib/trading_platform/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();
    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) quantity.value++;
  }

  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calulateTotalPrice(price){
    totalPrice.value =   price * quantity.value;
  }
}
