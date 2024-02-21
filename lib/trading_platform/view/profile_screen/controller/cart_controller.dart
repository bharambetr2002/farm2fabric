import 'package:farm2fabric/consts/consts.dart';

class CartController extends GetxController {
  var totalCart = 0.obs;

  calulate(data) {
    totalCart.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalCart.value =
          totalCart.value + int.parse(data[i]['tprice'].toString());
    }
  }
}
