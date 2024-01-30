import 'package:farm2fabric/authentication/controllers/auth_controller.dart';
import 'package:farm2fabric/consts/consts.dart';
import 'package:farm2fabric/authentication/view/login_screen.dart';
import 'package:farm2fabric/authentication/widgets_common/applogo_widget.dart';
import 'package:farm2fabric/authentication/widgets_common/bg_widget.dart';
import 'package:farm2fabric/authentication/widgets_common/custom_textfiled.dart';
import 'package:farm2fabric/authentication/widgets_common/our_button.dart';
import 'package:farm2fabric/customer_auth/home_customer.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool ischeck = false;
  var controller = Get.put(AuthControleer());

  // text controllers

  var nameController = TextEditingController(text: 'test user');
  var emailController = TextEditingController(text: 'test@gmail.com');
  var passwordController = TextEditingController(text: '123456');
  var passwordRetypeController = TextEditingController(text: '123456');

  @override
  Widget build(BuildContext context) {
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
                "Sign Up to $appname"
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
                          hint: nameHint,
                          title: name,
                          controller: nameController,
                          isPass: false),
                      customTextField(
                          hint: emailHint,
                          title: email,
                          controller: emailController,
                          isPass: false),
                      customTextField(
                          hint: passwordHint,
                          title: password,
                          controller: passwordController,
                          isPass: true),
                      customTextField(
                          hint: passwordHint,
                          title: retypePassword,
                          controller: passwordRetypeController,
                          isPass: true),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {}, child: forgetPass.text.make()),
                      ),
                      5.heightBox,
                      Row(
                        children: [
                          Checkbox(
                              checkColor: whiteColor,
                              activeColor: redColor,
                              value: ischeck,
                              onChanged: (newValue) {
                                setState(() {
                                  ischeck = newValue!;
                                });
                              }),
                          10.widthBox,
                          Expanded(
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "I agree to the ",
                                  style: TextStyle(
                                      color: fontGrey, fontFamily: bold)),
                              TextSpan(
                                  text: termsandcond,
                                  style: TextStyle(
                                      color: redColor, fontFamily: bold)),
                              TextSpan(
                                  text: " & ",
                                  style: TextStyle(
                                      color: fontGrey, fontFamily: bold)),
                              TextSpan(
                                  text: privacyPolicy + " .",
                                  style: TextStyle(
                                      color: redColor, fontFamily: bold)),
                            ])),
                          )
                        ],
                      ),
                      controller.isloading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            )
                          : ourButton(
                              color: ischeck == true ? redColor : lightGrey,
                              title: signup,
                              textColor: whiteColor,
                              onPress: () async {
                                if (ischeck != false) {
                                  controller.isloading.value = true;
                                  try {
                                    await controller
                                        .signupMethod(
                                            context: context,
                                            email:
                                                emailController.text.toString(),
                                            password: passwordController.text
                                                .toString())
                                        .then((value) {
                                      return controller.storeUserData(
                                        email: emailController.text,
                                        name: nameController.text,
                                        password: passwordController.text,
                                      );
                                    }).then((value) {
                                      VxToast.show(context, msg: loggedin);
                                      Get.offAll(() => Home_Customer());
                                    });
                                  } catch (e) {
                                    auth.signOut();
                                    VxToast.show(context, msg: e.toString());
                                    controller.isloading.value = false;
                                  }
                                }
                              }).box.width(context.screenWidth - 50).make(),
                      10.heightBox,
                      RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                            text: "Already have an account? ",
                            style:
                                TextStyle(color: fontGrey, fontFamily: bold)),
                        TextSpan(
                            text: login,
                            style:
                                TextStyle(color: redColor, fontFamily: bold)),
                      ])).onTap(() {
                        Get.to(() => const loginScreen());
                      })
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
