import 'package:farm2fabric/consts/consts.dart';
import 'package:farm2fabric/trading_platform/controller/home_controller.dart';

class CartController extends GetxController {
  var totalCart = 0.obs;

// test controllers for shipping details
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalcodeController = TextEditingController();
  var phoneController = TextEditingController();

  var paymentIndex = 0.obs;

  calulate(data) {
    totalCart.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalCart.value =
          totalCart.value + int.parse(data[i]['tprice'].toString());
    }
  }

  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

  placeMyOrder({orderPaymentMethod, totalAmount}) async {
    await firestore.collection(ordersCollection).doc().set({
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by_state': stateController.text,
      'order_by_city': cityController.text,
      'order_by_phone': phoneController.text,
      "order_by_postalcode": postalcodeController.text,
      "shipping_method": "Home Delivery",
      "payment method": orderPaymentMethod,
      'order placed': true,
      'total_amount': totalAmount,
    });
  }
}
