import 'package:farm2fabric/authentication/controllers/auth_controller.dart';
import 'package:farm2fabric/authentication/view/login_screen.dart';
import 'package:farm2fabric/authentication/widgets_common/bg_widget.dart';
import 'package:farm2fabric/consts/consts.dart';
import 'package:farm2fabric/consts/list.dart';
import 'package:farm2fabric/trading_platform/view/profile_screen/components/details_card.dart';

class TradingProfileScreen extends StatelessWidget {
  const TradingProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            body: SafeArea(
      child: Column(
        children: [
          //edit profile button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ).onTap(() {}),
          ),

          // user details button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Image.asset(imgProfile2, width: 100, fit: BoxFit.cover)
                    .box
                    .roundedFull
                    .clip(Clip.antiAlias)
                    .make(),
                10.widthBox,
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Trading Name".text.fontFamily(semibold).white.make(),
                    "customer@example.com".text.white.make(),
                  ],
                )),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 1, color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    await Get.put(AuthController()).signoutMethod(context);
                    Get.offAll(() => const loginScreen());
                  },
                  child: logout.text.fontFamily(semibold).white.make(),
                )
              ],
            ),
          ),
          10.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              detailsCard(
                  count: "00",
                  title: "in your cart",
                  width: context.screenWidth / 3.4),
              detailsCard(
                  count: "32",
                  title: "in your wishlist",
                  width: context.screenWidth / 3.4),
              detailsCard(
                  count: "9",
                  title: "in your orders",
                  width: context.screenWidth / 3.4),
            ],
          ),
          //Button Section
          ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return Divider(
                color: lightGrey,
              );
            },
            itemCount: profileButtonlList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Image.asset(
                  profileButtonlListIcon[index],
                  width: 22,
                ),
                title: profileButtonlList[index]
                    .text
                    .fontFamily(semibold)
                    .color(darkFontGrey)
                    .make(),
              );
            },
          )
              .box
              .white
              .rounded
              .margin(EdgeInsets.all(12))
              .padding(EdgeInsets.symmetric(horizontal: 16))
              .shadowSm
              .make()
              .box
              .color(redColor)
              .make(),
        ],
      ),
    )));
  }
}
