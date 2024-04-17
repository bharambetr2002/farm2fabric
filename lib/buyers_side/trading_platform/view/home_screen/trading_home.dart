import 'package:farm2fabric/consts/consts.dart';
import 'package:farm2fabric/buyers_side/trading_platform/controller/home_controller.dart';
import 'package:farm2fabric/buyers_side/trading_platform/view/cart_screen/trading_cartscreen.dart';
import 'package:farm2fabric/buyers_side/trading_platform/view/category_screen/trading_categoryscreen.dart';
import 'package:farm2fabric/buyers_side/trading_platform/view/home_screen/trading_homescreen.dart';
import 'package:farm2fabric/buyers_side/trading_platform/view/profile_screen/trading_profilescreen.dart';
import 'package:farm2fabric/buyers_side/widgets_common/exit_dialog.dart';

class TradingHome extends StatelessWidget {
  const TradingHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //init home controller
    var controller = Get.put(HomeController());

    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 26,
          ),
          label: catgories),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCart,
            width: 26,
          ),
          label: cart),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: account)
    ];

    var navBody = [
      TradingHomeScreen(),
      TradingCategoryScreen(),
      TradingCartScreen(),
      TradingProfileScreen()
    ];

    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDiaglog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(
              () => Expanded(
                  child: navBody.elementAt(controller.currentNavIndex.value)),
            )
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: redColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            items: navbarItem,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
