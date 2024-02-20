import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm2fabric/authentication/widgets_common/bg_widget.dart';
import 'package:farm2fabric/consts/consts.dart';
import 'package:farm2fabric/services/firestore_services.dart';
import 'package:farm2fabric/trading_platform/controller/product_contoller.dart';
import 'package:farm2fabric/trading_platform/view/category_screen/item_details.dart';
import 'package:farm2fabric/trading_platform/view/widgets_common/loading_indicator.dart';

class CategroryDetails extends StatelessWidget {
  final String? title;
  const CategroryDetails({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: title!.text.fontFamily(bold).white.make(),
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getProducts(title),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: loadingIndicator());
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                  child:
                      "No products available".text.color(darkFontGrey).make());
            } else {
              var data = snapshot.data!.docs;

              return Container(
                padding: EdgeInsets.all(8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                controller.subcat.length,
                                (index) => "${controller.subcat[index]}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .size(12)
                                    .makeCentered()
                                    .box
                                    .roundedSM
                                    .white
                                    .size(150, 60)
                                    .margin(EdgeInsets.symmetric(horizontal: 4))
                                    .make()),
                          )),
                      20.heightBox,
                      Expanded(
                          child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisExtent: 250,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      data[index]["p_imgs"][0],
                                      height: 150,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    ),
                                    10.heightBox,
                                    "${data[index]["p_name"]}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    "${data[index]["p_price"]}"
                                        // TODO : add locale currency
                                        .numCurrency
                                        .text
                                        .fontFamily(bold)
                                        .color(redColor)
                                        .size(16)
                                        .make(),
                                  ],
                                )
                                    .box
                                    .white
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .outerShadow
                                    .roundedSM
                                    .padding(EdgeInsets.all(12))
                                    .make()
                                    .onTap(() {
                                  Get.to(() => ItemDetails(
                                      title: "${data[index]["p_name"]}", data : data[index]));
                                });
                              })),
                    ]),
              );
            }
          },
        ),
      ),
    );
  }
}
