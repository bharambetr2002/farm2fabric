import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm2fabric/authentication/controllers/auth_controller.dart';
import 'package:farm2fabric/authentication/view/login_screen.dart';
import 'package:farm2fabric/widgets_common/bg_widget.dart';
import 'package:farm2fabric/consts/consts.dart';
import 'package:farm2fabric/consts/list.dart';
import 'package:farm2fabric/trading_platform/view/profile_screen/components/details_card.dart';
import 'package:farm2fabric/trading_platform/view/profile_screen/controller/profile_controller.dart';
import 'package:farm2fabric/trading_platform/view/profile_screen/edit_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TradingProfileScreen extends StatelessWidget {
  const TradingProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor)));
            } else {
              var data = snapshot.data!.data() as Map<String, dynamic>;
              return SafeArea(
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
                      ).onTap(() {
                        controller.nameController.text = data['name'];

                        Get.to(() => EditProfileScreen(data: data));
                      }),
                    ),

                    // user details button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          data['imgUrl'] == ''
                              ? Image.asset(imgProfile2,
                                      width: 100, fit: BoxFit.cover)
                                  .box
                                  .roundedFull
                                  .clip(Clip.antiAlias)
                                  .make()
                              : Image.network(data['imgUrl'],
                                      width: 100, fit: BoxFit.cover)
                                  .box
                                  .roundedFull
                                  .clip(Clip.antiAlias)
                                  .make(),
                          10.widthBox,
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${data['name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .white
                                  .make(),
                              "${data['email']}".text.white.make(),
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
                              bool confirmed = await Get.dialog(
                                AlertDialog(
                                  title: Text('Confirm Logout'),
                                  content:
                                      Text('Are you sure you want to logout?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Get.back(
                                            result:
                                                false); // Close dialog and return false
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.back(
                                            result:
                                                true); // Close dialog and return true
                                      },
                                      child: Text('Logout'),
                                    ),
                                  ],
                                ),
                              );

                              if (confirmed != null && confirmed) {
                                await Get.find<AuthController>().signout();
                                Get.offAll(() => const loginScreen());
                              }
                            },

                            child:
                                logout.text.fontFamily(semibold).white.make(),
                          )
                        ],
                      ),
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        detailsCard(
                            count: "${data['cart_count']}",
                            title: "in your cart",
                            width: context.screenWidth / 3.4),
                        detailsCard(
                            count: "${data['wishlist_count']}",
                            title: "in your wishlist",
                            width: context.screenWidth / 3.4),
                        detailsCard(
                            count: "${data['order_count']}",
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
              );
            }
          },
        ),
      ),
    );
  }
}
