import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm2fabric/consts/consts.dart';
import 'package:farm2fabric/trading_platform/controller/home_controller.dart';

class CartController extends GetxController {
  var totalCart = 0.obs;

// test controllers for shipping details
  var addressController =
      TextEditingController(text: 'Mahindra Co op housing Society');
  var cityController = TextEditingController(text: 'Nasik');
  var stateController = TextEditingController(text: 'Maharashtra');
  var postalcodeController = TextEditingController(text: '422005');
  var phoneController = TextEditingController(text: '0000000000');

  var paymentIndex = 0.obs;
  late dynamic productSnapshot;
  var products = [];

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

  placeMyOrder({required orderPaymentMethod, required totalAmount}) async {
    await getProductDetails();
    await firestore.collection(ordersCollection).doc().set({
      'order_code': "233981237",
      'order_date': FieldValue.serverTimestamp(),
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
      'order _confirmed': false,
      'order delivered': false,
      'order _on _delivery': false,
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(products)
    });
  }

  getProductDetails() {
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'img': productSnapshot[i]['img'],
        'qty': productSnapshot[i]['qty'],
        'title': productSnapshot[i]['title'],
      });
    }
    print(products);
  }
}
