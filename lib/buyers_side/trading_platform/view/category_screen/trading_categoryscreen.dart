import 'package:farm2fabric/buyers_side/widgets_common/bg_widget.dart';
import 'package:farm2fabric/consts/consts.dart';
import 'package:farm2fabric/consts/list.dart';
import 'package:farm2fabric/buyers_side/trading_platform/controller/product_contoller.dart';
import 'package:farm2fabric/buyers_side/trading_platform/view/category_screen/category_details.dart';

class TradingCategoryScreen extends StatelessWidget {
  const TradingCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
              title: catgories.text.fontFamily(bold).white.make(),
            ),
            body: Container(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 200,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Image.asset(
                        categoryImg[index],
                        height: 120,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                      10.heightBox,
                      categoryList[index]
                          .text
                          .color(darkFontGrey)
                          .align(TextAlign.center)
                          .make(),
                    ],
                  )
                      .box
                      .white
                      .roundedSM
                      .clip(Clip.antiAlias)
                      .outerShadowSm
                      .make()
                      .onTap(() {
                    controller.getSubCategorys(categoryList[index]);
                    Get.to(() => CategroryDetails(
                          title: categoryList[index],
                        ));
                  });
                },
              ),
            )));
  }
}
