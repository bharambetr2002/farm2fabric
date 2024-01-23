import 'package:farm2fabric/consts/consts.dart';
import 'package:farm2fabric/consts/list.dart';
import 'package:farm2fabric/authentication/view/signup_screen.dart';
import 'package:farm2fabric/authentication/widgets_common/applogo_widget.dart';
import 'package:farm2fabric/authentication/widgets_common/bg_widget.dart';
import 'package:farm2fabric/authentication/widgets_common/our_button.dart';
import 'package:farm2fabric/authentication/widgets_common/custom_textfiled.dart';
import 'package:farm2fabric/farmer_auth/home_farmer.dart';
import 'package:get/get.dart';

class loginScreen extends StatelessWidget{
  const loginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
      return bgWidget(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight* 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Column(
                children: [
                  customTextField(hint: emailHint, title: email),
                  customTextField(hint: passwordHint, title: password),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(onPressed: (){}, child: forgetPass.text.make()),
                  ),
                  5.heightBox,  
                  ourButton(color : redColor, title: login, textColor: whiteColor, onPress: (){
                    Get.to(() => const Home_Farmer());
                  }).box.width(context.screenWidth -50).make(),
                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  ourButton(color : golden, title: signup, textColor: whiteColor, onPress: (){
                    Get.to(() => const SignupScreen());
                  }).box.width(context.screenWidth -50).make(),
                  10.heightBox,
                  loginWith.text.color(fontGrey).make(),
                  5.heightBox,
                  Row(  
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: lightGrey,
                        radius: 25,
                        child: Image.asset(socialIconList[index],width: 30,),
                      ),
                    ))
                  )
                ],
            
              ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth -70).shadowSm.make()
             ],
          ),
        )
      ));
  }
}