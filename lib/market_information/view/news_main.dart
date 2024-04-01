import 'package:farm2fabric/market_information/controller/fetch_news.dart';
import 'package:farm2fabric/market_information/model/news_article.dart';
import 'package:farm2fabric/market_information/view/widgets/newscontainer.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  bool isLoading = true;
  late NewsArt newsArt;

  Future<void> getNews() async {
    newsArt = await FetchNews.fetchNews();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "Market",
              style: TextStyle(fontSize: 22),
            ),
            Text(
              " ",
              style: TextStyle(fontSize: 22),
            ),
            Text(
              "Information",
              style: TextStyle(fontSize: 22, color: Colors.white),
            )
          ],
        ),
        backgroundColor: Colors.blue,
        elevation: 0.0,
      ),
      body: PageView.builder(
        controller: PageController(initialPage: 0),
        scrollDirection: Axis.vertical,
        onPageChanged: (value) {
          setState(() {
            isLoading = true;
          });
          getNews();
        },
        itemBuilder: (context, index) {
          return isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : NewsContainer(
                  imgUrl: newsArt.imgUrl,
                  newsCnt: newsArt.newsCnt,
                  newsHead: newsArt.newsHead,
                  newsDes: newsArt.newsDes,
                  newsUrl: newsArt.newsUrl,
                );
        },
      ),
    );
  }
}
