import 'dart:convert';

import 'package:flutter_news_app/model/show_category_model.dart';
import 'package:flutter_news_app/model/slider_model.dart';
import 'package:http/http.dart' as http;

class ShowCategoryNews {
  List<ShowCategoryModel> categoriesNews = [];

  getCategoriesNews(String category) async {
    String apiUrl =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=0a0d1ef7122b4e7ba5de87dd6c2383f5";

    var response = await http.get(Uri.parse(apiUrl));
    try {
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        data["articles"].forEach((element) {
          if (element["urlToImage"] != null && element["description"] != null) {
            ShowCategoryModel categoryModel = ShowCategoryModel(
                element["author"],
                element["title"],
                element["description"],
                element["url"],
                element["urlToImage"],
                element["content"]);
            categoriesNews.add(categoryModel);
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
