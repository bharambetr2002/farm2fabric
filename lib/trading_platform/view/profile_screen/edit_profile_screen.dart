import 'dart:io';

import 'package:farm2fabric/authentication/widgets_common/bg_widget.dart';
import 'package:farm2fabric/authentication/widgets_common/custom_textfiled.dart';
import 'package:farm2fabric/authentication/widgets_common/our_button.dart';
import 'package:farm2fabric/consts/consts.dart';
import 'package:farm2fabric/trading_platform/view/profile_screen/controller/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return bgWidget(
        child: Scaffold(
            appBar: AppBar(),
            body: Obx(() => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    controller.profileImgPath.isEmpty
                        ? Image.asset(imgProfile2,
                                width: 100, fit: BoxFit.cover)
                            .box
                            .roundedFull
                            .clip(Clip.antiAlias)
                            .make()
                        : Image.file(File(controller.profileImgPath.value),
                                width: 100, fit: BoxFit.cover)
                            .box
                            .roundedFull
                            .clip(Clip.antiAlias)
                            .make(),
                    10.heightBox,
                    ourButton(
                        color: redColor,
                        onPress: () {
                          controller.changeImage(context);
                        },
                        textColor: whiteColor,
                        title: "Change"),
                    Divider(),
                    20.heightBox,
                    customTextField(hint: nameHint, title: name, isPass: false),
                    customTextField(
                        hint: password, title: password, isPass: true),
                    20.heightBox,
                    SizedBox(
                      width: context.screenWidth - 60,
                      child: ourButton(
                          color: redColor,
                          onPress: () {},
                          textColor: whiteColor,
                          title: "Save"),
                    )
                  ],
                )
                    .box
                    .white
                    .shadowSm
                    .padding(EdgeInsets.all(16))
                    .margin(EdgeInsets.only(top: 50, left: 12, right: 12))
                    .rounded
                    .make())));
  }
}
