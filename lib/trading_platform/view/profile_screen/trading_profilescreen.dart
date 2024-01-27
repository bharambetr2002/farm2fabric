import 'package:farm2fabric/authentication/widgets_common/bg_widget.dart';
import 'package:farm2fabric/consts/consts.dart';
import 'package:farm2fabric/trading_platform/view/profile_screen/components/details_card.dart';

class TradingProfileScreen extends StatelessWidget {
  const TradingProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            body: SafeArea(
                child: Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          //edit profile button
          const Align(
            alignment: Alignment.topRight,
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ).onTap(() {}),

          // user details button
          Row(
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
                onPressed: () {},
                child: logout.text.fontFamily(semibold).white.make(),
              )
            ],
          ),
          20.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              detailsCard(count: "00", title: "in your cart",width: context.screenWidth/3.4),
              detailsCard(count: "32", title: "in your wishlist",width: context.screenWidth/3.4),
              detailsCard(count: "9", title: "in your orders",width: context.screenWidth/3.4),
            ],
          )
        ],
      ),
    ))));
  }
}
