import "package:farm2fabric/widgets_common/custom_textfiled.dart";
import "package:farm2fabric/widgets_common/our_button.dart";
import "package:farm2fabric/consts/consts.dart";
import "package:farm2fabric/trading_platform/view/cart_screen/paymentmethod.dart";
import "package:farm2fabric/trading_platform/view/profile_screen/controller/cart_controller.dart";

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Shipping Info"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: ourButton(
            onPress: () {
              if (controller.addressController.text.length > 10) {
                Get.to(() => PaymentMethods());
              } else {
                VxToast.show(context, msg: "Please Fill the form");
              }
            },
            color: redColor,
            textColor: whiteColor,
            title: "Continue",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              customTextField(
                  hint: "Address",
                  isPass: false,
                  title: "Address",
                  controller: controller.addressController),
              customTextField(
                  hint: "City",
                  isPass: false,
                  title: "City",
                  controller: controller.cityController),
              customTextField(
                  hint: "State",
                  isPass: false,
                  title: "State",
                  controller: controller.stateController),
              customTextField(
                  hint: "Postal Code",
                  isPass: false,
                  title: "Postal Code",
                  controller: controller.postalcodeController),
              customTextField(
                  hint: "Phone",
                  isPass: false,
                  title: "Phone",
                  controller: controller.phoneController),
            ],
          ),
        ));
  }
}
