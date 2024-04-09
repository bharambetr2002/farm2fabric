import 'dart:io';
import 'package:farm2fabric/buyers_side/widgets_common/bg_widget.dart';
import 'package:farm2fabric/buyers_side/widgets_common/custom_textfiled.dart';
import 'package:farm2fabric/buyers_side/widgets_common/our_button.dart';
import 'package:farm2fabric/buyers_side/consts/consts.dart';
import 'package:farm2fabric/buyers_side/trading_platform/view/profile_screen/controller/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;

  const EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
            appBar: AppBar(),
            body: Obx(() => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // if data imageUrl path is empty and cotroller path is empty

                    data['imgUrl'] == '' && controller.profileImgPath.isEmpty
                        ? Image.asset(imgProfile2,
                                width: 100, fit: BoxFit.cover)
                            .box
                            .roundedFull
                            .clip(Clip.antiAlias)
                            .make()

                        // if data image is not empty but cotroller path is empty
                        : data['imgUrl'] != '' &&
                                controller.profileImgPath.isEmpty
                            ? Image.network(data['imgUrl'],
                                    width: 100, fit: BoxFit.cover)
                                .box
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make()

                            // if both are empty
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
                    customTextField(
                        controller: controller.nameController,
                        hint: nameHint,
                        title: name,
                        isPass: false),
                    10.heightBox,
                    customTextField(
                        controller: controller.oldpasswordController,
                        hint: passwordHint,
                        title: oldpass,
                        isPass: true),
                    10.heightBox,
                    customTextField(
                        controller: controller.newpasswordController, //
                        hint: passwordHint,
                        title: newpass,
                        isPass: true),
                    20.heightBox,
                    controller.isLoading.value
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : SizedBox(
                            width: context.screenWidth - 60,
                            child: ourButton(
                                color: redColor,
                                onPress: () async {
                                  controller.isLoading(true);

                                  //if image is not changed

                                  if (controller
                                      .profileImgPath.value.isNotEmpty) {
                                    await controller.uploadProfileImage();
                                  } else {
                                    controller.profileImageLink =
                                        data['imgUrl'];
                                  }

                                  //check old password

                                  if (data['password'] ==
                                      controller.oldpasswordController.text) {
                                    await controller.changeAuthPassword(
                                      email: data['email'],
                                      password:
                                          controller.oldpasswordController.text,
                                      newpassword:
                                          controller.newpasswordController.text,
                                    );

                                    await controller.updateProfile(
                                        controller.nameController.text,
                                        controller.newpasswordController.text,
                                        controller.profileImageLink);
                                    VxToast.show(context,
                                        msg: "Profile Updated");
                                    return;
                                  } else {
                                    VxToast.show(context,
                                        msg: "Old Password is incorrect");
                                    controller.isLoading(false);
                                  }
                                },
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
