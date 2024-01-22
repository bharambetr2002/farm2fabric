import 'package:farm2fabric/market_information/view/detail_view.dart';
import 'package:flutter/material.dart';

class newscontainer extends StatelessWidget{

    String imgUrl;
    String newsHead;
    String newsDes;
    String newsUrl;
    String newsCnt;

   newscontainer({super.key , 
    required this.imgUrl ,
    required this.newsHead ,
    required this.newsDes ,
    required this.newsCnt ,
    required this.newsUrl
   });

  @override

  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        FadeInImage.assetNetwork(
            height: 200,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
            placeholder: "assets/img/placeholder.jfif",
            image: imgUrl),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 15,
            ),
            Text(
              newsHead.length > 120
                  ? "${newsHead.substring(0, 120)}..."
                  : newsHead,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              newsDes,
              style: TextStyle(fontSize: 14, color: const Color.fromARGB(96, 9, 8, 8)),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              newsCnt != "--"
                  ? newsCnt.length > 250
                      ? newsCnt.substring(0, 250)
                      : "${newsCnt.toString().substring(0, newsCnt.length - 15)}..."
                  : newsCnt,
              style: TextStyle(fontSize: 16),
            ),
          ]),
        ),
        Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailViewScreen(newsUrl: newsUrl)));
                  },
                  child: Text("Read More")),
            ),
          ],
        ),
      ]),
    );
  }
}