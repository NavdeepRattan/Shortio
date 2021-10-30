import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shortsio/models/article_model.dart';

class News {
  List<ArticleModel> newsList = [];
  Future<void> getNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=bd2268e4fa254e6889449d31092c18e0";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["url"] != null &&
            element["urlToImage"] != null &&
            element["description"] != null &&
            element["title"] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element["title"],
              author: element["author"],
              description: element["description"],
              urlToImage: element["urlToImage"],
              url: element["url"]);
          newsList.add(articleModel);
        }
      });
    }
  }
}
