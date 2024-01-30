import 'package:farm2fabric/authentication/controllers/auth_controller.dart';
import 'package:farm2fabric/consts/consts.dart';
import 'package:farm2fabric/consts/list.dart';
import 'package:farm2fabric/authentication/view/signup_screen.dart';
import 'package:farm2fabric/authentication/widgets_common/applogo_widget.dart';
import 'package:farm2fabric/authentication/widgets_common/bg_widget.dart';
import 'package:farm2fabric/authentication/widgets_common/our_button.dart';
import 'package:farm2fabric/authentication/widgets_common/custom_textfiled.dart';
import 'package:farm2fabric/customer_auth/home_customer.dart';

class loginScreen extends StatelessWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthControleer());

    return bgWidget(
        child: GestureDetector(
      // to hide keyboard when user click outside the textfield
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              children: [
                (context.screenHeight * 0.1).heightBox,
                applogoWidget(),
                10.heightBox,
                "Log in to $appname"
                    .text
                    .fontFamily(bold)
                    .white
                    .size(18)
                    .make(),
                15.heightBox,
                Obx(
                  () => Column(
                    children: [
                      customTextField(
                          hint: emailHint,
                          title: email,
                          isPass: false,
                          controller: controller.emailController),
                      customTextField(
                          hint: passwordHint,
                          title: password,
                          isPass: true,
                          controller: controller.passwordController),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {}, child: forgetPass.text.make()),
                      ),
                      5.heightBox,
                      controller.isloading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            )
                          : ourButton(
                              color: redColor,
                              title: login,
                              textColor: whiteColor,
                              onPress: () async {
                                controller.isloading.value = true;
                                await controller
                                    .loginMethod(context: context)
                                    .then((value) {
                                  if (value != null) {
                                    VxToast.show(context, msg: loggedin);
                                    Get.offAll(() => const Home_Customer());
                                  } else {
                                    controller.isloading.value = false;
                                  }
                                });
                              },
                            ).box.width(context.screenWidth - 50).make(),
                      5.heightBox,
                      createNewAccount.text.color(fontGrey).make(),
                      ourButton(
                          color: golden,
                          title: signup,
                          textColor: whiteColor,
                          onPress: () {
                            Get.to(() => const SignupScreen());
                          }).box.width(context.screenWidth - 50).make(),
                      10.heightBox,
                      loginWith.text.color(fontGrey).make(),
                      5.heightBox,
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                              3,
                              (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundColor: lightGrey,
                                      radius: 25,
                                      child: Image.asset(
                                        socialIconList[index],
                                        width: 30,
                                      ),
                                    ),
                                  )))
                    ],
                  )
                      .box
                      .white
                      .rounded
                      .padding(const EdgeInsets.all(16))
                      .width(context.screenWidth - 70)
                      .shadowSm
                      .make(),
                )
              ],
            ),
          )),
    ));
  }
}
