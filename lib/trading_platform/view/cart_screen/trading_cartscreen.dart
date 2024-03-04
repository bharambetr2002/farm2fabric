import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm2fabric/authentication/widgets_common/our_button.dart';
import 'package:farm2fabric/consts/consts.dart';
import 'package:farm2fabric/services/firestore_services.dart';
import 'package:farm2fabric/trading_platform/view/cart_screen/shipping_screen.dart';
import 'package:farm2fabric/trading_platform/view/profile_screen/controller/cart_controller.dart';
import 'package:farm2fabric/trading_platform/view/widgets_common/loading_indicator.dart';

class TradingCartScreen extends StatelessWidget {
  const TradingCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: SizedBox(
        height: 50,
        child: ourButton(
            color: redColor,
            onPress: () {
              Get.to(() => ShippingDetails());
            },
            textColor: whiteColor,
            title: "Procedd To Shipping "),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping Cart"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "Cart Is Empty".text.color(darkFontGrey).make(),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.calulate(data);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Image.network("${data[index]['img']}"),
                            title:
                                "${data[index]['title']} x(${data[index]['qty']})"
                                    .text
                                    .fontFamily(semibold)
                                    .size(16)
                                    .make(),
                            subtitle: "${data[index]['tprice']}"
                                .numCurrency
                                .text
                                .fontFamily(semibold)
                                .color(redColor)
                                .size(16)
                                .make(),
                            trailing: Icon(
                              Icons.delete,
                              color: redColor,
                            ).onTap(() {
                              FirestoreServices.deleteDocument(data[index].id);
                            }),
                          );
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total Price"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      Obx(() => "${controller.totalCart.value}"
                          .numCurrency
                          .text
                          .fontFamily(semibold)
                          .color(redColor)
                          .make())
                    ],
                  )
                      .box
                      .padding(EdgeInsets.all(12))
                      .color(lightGrey)
                      .width(context.screenWidth - 60)
                      .roundedLg
                      .make(),
                  10.heightBox,
                  // SizedBox(
                  //   width: context.screenWidth - 60,
                  //   child: (ourButton(
                  //       color: redColor,
                  //       onPress: () {},
                  //       textColor: whiteColor,
                  //       title: "Procedd To Shipping ")),
                  // )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
