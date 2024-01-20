import 'dart:convert';
import 'dart:math';
import 'package:farm2fabric/model/newsArt.dart';
import 'package:http/http.dart';

class FetchNews{
    static List sourcesId = [];

  static Future<NewsArt> fetchNews() async {
    final _random = new Random();
    var sourceID = sourcesId[_random.nextInt(sourcesId.length)];
   
    Response response = await get(Uri.parse("https://newsapi.org/v2/everything?q=bitcoin&apiKey=b95fcca3d9df40ecba038178fb298866"));

    Map body_data = jsonDecode(response.body);
    List articles = body_data["articles"];
  
    final _Newrandom = new Random();
    var myArticle = articles[_random.nextInt(articles.length)];
 

    return NewsArt.fromAPItoApp(myArticle);
  }
}