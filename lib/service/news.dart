import 'dart:convert';

import 'package:flutter_news_app/model/article_model.dart';
import 'package:http/http.dart' as http;

class NewsService {
  List<ArticleModel> news = [];

  getData() async {
    String apiKey =
        "0a0d1ef7122b4e7ba5de87dd6c2383f5"; // Replace with your actual API key
    String query = "apple"; // You can change this as needed

// Get the news  date
    String currentDate = DateTime.now()
        .subtract(Duration(days: 1))
        .toIso8601String()
        .split('T')[0];

    String apiUrl =
        "https://newsapi.org/v2/everything?q=$query&from=$currentDate&to=$currentDate&sortBy=popularity&apiKey=$apiKey";

    var response = await http.get(Uri.parse(apiUrl));
    try {
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        data["articles"].forEach((element) {
          if (element["urlToImage"] != null && element["description"] != null) {
            ArticleModel articleModel = ArticleModel(
                element["author"],
                element["title"],
                element["description"],
                element["url"],
                element["urlToImage"],
                element["content"]);
            news.add(articleModel);
          }
        });
      } else {
        throw Exception("Failed to load news");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
