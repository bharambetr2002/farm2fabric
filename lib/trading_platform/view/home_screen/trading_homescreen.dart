import 'package:farm2fabric/consts/consts.dart';
import 'package:farm2fabric/trading_platform/view/widgets_common/home_buttons.dart';

class TradingHomeScreen extends StatelessWidget{
  const TradingHomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: Column(

        // search bar
        
        children: [
          HeightBox(context.screenWidth * 0.1),
          Container(
            
            alignment: Alignment.center,
            height: 60,
            color: lightGrey,
            child: TextFormField(
              decoration:InputDecoration(
                filled: true,fillColor: whiteColor,
                hintText: seachanything,
                hintStyle: TextStyle(color: textfieldGrey),
                suffixIcon: Icon(Icons.search, color: textfieldGrey,),
              )
            ),
          ),

          // top categories & top seller

          10.heightBox,
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            2,
            (index) => homeButtons(
            width: context.screenWidth * 0.45,
            height: context.screenWidth / 2.5,
            icon: index ==0 ? icTopCategories : index == 1 ? icTopSeller: icTopSeller,
            title: index ==0 ? topCategory : index == 1 ? topSeller: topSeller,
          )) ),

          // featured category
          10.heightBox,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(featuredCategory, style: TextStyle(fontFamily: semibold, fontSize: 18),)),
          10.heightBox,

        ],
      ),
    );
  }
}