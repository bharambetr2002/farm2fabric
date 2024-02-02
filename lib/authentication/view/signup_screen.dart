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
  bool isCheck = false;

  //authcontroller
  var controller = Get.put(AuthController());

//textcontrollers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordretypeController = TextEditingController();

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

                //signup form
                Obx(
                  () => Column(
                    children: [
                      customTextField(
                          hint: nameHint,
                          isPass: false,
                          title: name,
                          controller: nameController),
                      customTextField(
                          hint: emailHint,
                          isPass: false,
                          title: email,
                          controller: emailController),
                      customTextField(
                          hint: passwordHint,
                          isPass: true,
                          title: password,
                          controller: passwordController),
                      customTextField(
                          hint: passwordHint,
                          isPass: true,
                          title: retypePassword,
                          controller: passwordretypeController),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {}, child: forgetPass.text.make()),
                      ),

                      5.heightBox,

                      //checkbox for terms and conditions
                      Row(
                        children: [
                          Checkbox(
                            checkColor: whiteColor,
                            activeColor: redColor,
                            value: isCheck,
                            onChanged: (newValue) {
                              setState(
                                () {
                                  isCheck = newValue!;
                                },
                              );
                            },
                          ),

                          10.widthBox,

                          //terms and conditions
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
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
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      //circular loading indicator
                      controller.isloading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            )

                          //signup button
                          : ourButton(
                              color: isCheck == true ? redColor : lightGrey,
                              title: signup,
                              textColor: whiteColor,
                              onPress: () async {
                                if (isCheck != false) {
                                  controller.isloading(true);
                                  try {
                                    await controller
                                        .signupMethod(
                                            context: context,
                                            email: emailController.text,
                                            password: passwordController.text)
                                        .then((value) {
                                      return controller.storeUserData(
                                          email: emailController.text,
                                          name: nameController.text,
                                          password: passwordController.text);
                                    }).then(
                                      (value) {
                                        VxToast.show(context, msg: loginIn);
                                        Get.offAll(() => Home_Customer());
                                      },
                                    );
                                  } catch (e) {
                                    controller.isloading(false);
                                    auth.signOut();
                                    VxToast.show(context, msg: e.toString());
                                  }
                                }
                              },
                            ).box.width(context.screenWidth - 50).make(),

                      10.heightBox,

                      // login redirection
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                                text: "Already have an account? ",
                                style: TextStyle(
                                    color: fontGrey, fontFamily: bold)),
                            TextSpan(
                                text: login,
                                style: TextStyle(
                                    color: redColor, fontFamily: bold)),
                          ],
                        ),
                      ).onTap(
                        () {
                          Get.to(() => const loginScreen());
                        },
                      )
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
          ),
        ),
      ),
    );
  }
}
