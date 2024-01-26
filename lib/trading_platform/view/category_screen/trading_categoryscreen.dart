import 'package:farm2fabric/authentication/widgets_common/bg_widget.dart';
import 'package:farm2fabric/consts/consts.dart';
import 'package:farm2fabric/consts/list.dart';
import 'package:farm2fabric/trading_platform/view/category_screen/category_details.dart';

class TradingCategoryScreen extends StatelessWidget {
  const TradingCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
              title: catgories.text.fontFamily(bold).white.make(),
            ),
            body: Container(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 9,
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
                    Get.to(() => CategroryDetails(
                          title: categoryList[index],
                        ));
                  });
                },
              ),
            )));
  }
}
