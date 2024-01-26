import 'package:farm2fabric/consts/consts.dart';
import 'package:farm2fabric/consts/list.dart';
import 'package:farm2fabric/trading_platform/view/widgets_common/featured_button.dart';
import 'package:farm2fabric/trading_platform/view/widgets_common/home_buttons.dart';

class TradingHomeScreen extends StatelessWidget {
  const TradingHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12),
        color: lightGrey,
        width: context.screenWidth,
        height: context.screenHeight,
        child: Column(
          // search bar

          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                  decoration: InputDecoration(
                filled: true,
                fillColor: whiteColor,
                hintText: seachanything,
                hintStyle: TextStyle(color: textfieldGrey),
                suffixIcon: Icon(
                  Icons.search,
                  color: textfieldGrey,
                ),
              )),
            ),
            10.heightBox,
            Expanded(
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                              2,
                              (index) => homeButtons(
                                    width: context.screenWidth * 0.45,
                                    height: context.screenWidth / 2.5,
                                    icon: index == 0
                                        ? icTopCategories
                                        : index == 1
                                            ? icTopSeller
                                            : icTopSeller,
                                    title: index == 0
                                        ? topCategory
                                        : index == 1
                                            ? topSeller
                                            : topSeller,
                                  ))),

                      // featured category
                      10.heightBox,
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            featuredCategory,
                            style:
                                TextStyle(fontFamily: semibold, fontSize: 18),
                          )),

                      20.heightBox,
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              3,
                              (index) => Column(
                                children: [
                                  featuredButton(
                                      icon: featureImage1[index],
                                      title: featureTitles1[index]),
                                  10.heightBox,
                                  featuredButton(
                                      icon: featureImage2[index],
                                      title: featureTitles2[index])
                                ],
                              ),
                            ),
                          )),

                      // featured products
                      20.heightBox,
                      Container(
                          padding: const EdgeInsets.all(12),
                          width: double.infinity,
                          decoration: BoxDecoration(color: redColor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              featureProduct.text.white
                                  .fontFamily(bold)
                                  .size(18)
                                  .make(),
                              20.heightBox,
                              SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                        6,
                                        (index) => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                  imgP1,
                                                  width: 150,
                                                  fit: BoxFit.cover,
                                                ),
                                                10.heightBox,
                                                "Wool 4kg"
                                                    .text
                                                    .fontFamily(semibold)
                                                    .color(darkFontGrey)
                                                    .make(),
                                                10.heightBox,
                                                "Rs. 2000"
                                                    .text
                                                    .fontFamily(bold)
                                                    .color(redColor)
                                                    .size(16)
                                                    .make(),
                                              ],
                                            )
                                                .box
                                                .white
                                                .margin(
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4))
                                                .roundedSM
                                                .padding(EdgeInsets.all(8))
                                                .make()),
                                  )),
                            ],
                          )),
                      //
                      20.heightBox,
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            allProduct,
                            style: TextStyle(
                                color: Colors.red,
                                fontFamily: semibold,
                                fontSize: 18),
                          )),
                      GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 6,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  mainAxisExtent: 300),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  imgP5,
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                const Spacer(),
                                10.heightBox,
                                "Wool 4kg"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                10.heightBox,
                                "Rs. 2000"
                                    .text
                                    .fontFamily(bold)
                                    .color(redColor)
                                    .size(16)
                                    .make(),
                              ],
                            )
                                .box
                                .white
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 4))
                                .roundedSM
                                .padding(EdgeInsets.all(12))
                                .make();
                          })
                    ])))
          ],
        ));
  }
}
