import 'package:farm2fabric/buyers_side/widgets_common/our_button.dart';
import 'package:farm2fabric/buyers_side/consts/consts.dart';
import 'package:farm2fabric/buyers_side/consts/list.dart';
import 'package:farm2fabric/buyers_side/trading_platform/view/profile_screen/controller/cart_controller.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Choose Payment Method"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: ourButton(
            onPress: () async{
              controller.placeMyOrder(
                  orderPaymentMethod:
                      paymentMethods[controller.paymentIndex.value],
                  totalAmount: controller.totalCart.value);
            },
            color: redColor,
            textColor: whiteColor,
            title: "Place my Order",
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8),
            child: Obx(
              () => Column(
                children: List.generate(
                  paymentMethodsListImg.length,
                  (index) {
                    return GestureDetector(
                      onTap: () {
                        controller.paymentIndex(index);
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: controller.paymentIndex.value == index
                                  ? redColor
                                  : Colors.transparent,
                              width: 3.5,
                            )),
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.asset(
                              paymentMethodsListImg[index],
                              width: double.infinity,
                              height: 120,
                              fit: BoxFit.cover,
                              colorBlendMode:
                                  controller.paymentIndex.value == index
                                      ? BlendMode.darken
                                      : BlendMode.color,
                              color: controller.paymentIndex.value == index
                                  ? Colors.black.withOpacity(0.4)
                                  : Colors.transparent,
                            ),
                            controller.paymentIndex.value == index
                                ? Transform.scale(
                                    scale: 1.3,
                                    child: Checkbox(
                                        activeColor: Colors.green,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        value: true,
                                        onChanged: (value) {}),
                                  )
                                : Container(),
                            Positioned(
                                bottom: 10,
                                right: 10,
                                child: paymentMethods[index]
                                    .text
                                    .white
                                    .fontFamily(semibold)
                                    .size(16)
                                    .make()),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )));
  }
}
