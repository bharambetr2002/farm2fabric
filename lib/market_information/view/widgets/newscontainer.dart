import 'package:farm2fabric/market_information/view/detail_view.dart';
import 'package:flutter/material.dart';

class NewsContainer extends StatelessWidget {
  final String imgUrl;
  final String newsHead;
  final String newsDes;
  final String newsUrl;
  final String newsCnt;

  NewsContainer({
    Key? key,
    required this.imgUrl,
    required this.newsHead,
    required this.newsDes,
    required this.newsCnt,
    required this.newsUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9, // Maintain aspect ratio of the image
            child: FadeInImage.assetNetwork(
              fit: BoxFit.cover,
              placeholder: "assets/images/placeholder.jfif",
              image: imgUrl,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Text(
                  newsHead.length > 120
                      ? "${newsHead.substring(0, 120)}..."
                      : newsHead,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                Text(
                  newsDes,
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color.fromARGB(96, 9, 8, 8),
                  ),
                ),
                SizedBox(height: 15),
                // Text(
                //   newsCnt != "--"
                //       ? newsCnt.length > 250
                //           ? newsCnt.substring(0, 250)
                //           : "${newsCnt.toString().substring(0, newsCnt.length - 15)}..."
                //       : newsCnt,
                //   style: TextStyle(fontSize: 16),
                // ),
                // SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailViewScreen(newsUrl: newsUrl),
                        ),
                      );
                    },
                    child: Text("Read More"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
