import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm2fabric/consts/consts.dart';
import 'package:farm2fabric/trading_platform/models/category_model.dart';
import 'package:flutter/services.dart';

class ProductController extends GetxController {
  var subcat = [];
  var quantity = 0.obs;
  var totalPrice = 0.obs;
  var isFav = false.obs;

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

  calulateTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  addToCart({title, img, sellername, qty, tprice, context}) async {
    if (quantity.value == 0) {
      VxToast.show(context, msg: "Add at least one product");
    } else {
      try {
        // Check if the product already exists in the cart for the current user
        var existingProduct = await firestore
            .collection(cartCollection)
            .where('title', isEqualTo: title)
            .where('sellername', isEqualTo: sellername)
            .where('added_by', isEqualTo: currentUser!.uid)
            .limit(1) // Limit to 1 document
            .get();

        if (existingProduct.docs.isNotEmpty) {
          // If the product exists, update the quantity
          var docId = existingProduct.docs[0].id;
          var currentQty = existingProduct.docs[0]['qty'] ?? 0;
          await firestore.collection(cartCollection).doc(docId).update({
            'qty': currentQty + quantity.value, // Increment the quantity
            'tprice': (currentQty + quantity.value) *
                tprice // Recalculate total price
          });
        } else {
          // If the product doesn't exist, add a new document
          await firestore.collection(cartCollection).doc().set({
            'title': title,
            'img': img,
            'sellername': sellername,
            'qty': quantity.value,
            'tprice': tprice * quantity.value,
            'added_by': currentUser!.uid
          });
        }
        VxToast.show(context, msg: "Added to cart");
      } catch (error) {
        VxToast.show(context, msg: error.toString());
      }
    }
  }

  resetValues() {
    totalPrice.value = 0;
    quantity.value = 0;
  }

  addToWishlist(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Added to wishlist");
  }

  removeFromWishlist(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Removed from wishlist");
  }

  checkIfFav(data) async {
    if (data['p_wishlist'].contains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
