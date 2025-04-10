import 'dart:convert';

import 'package:flutter_news_app/model/slider_model.dart';
import 'package:http/http.dart' as http;

class SliderNewsService {
  List<SliderModel> sliderList = [];

  getSlider() async {
    String apiUrl =
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=0a0d1ef7122b4e7ba5de87dd6c2383f5";

    var response = await http.get(Uri.parse(apiUrl));
    try {
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        data["articles"].forEach((element) {
          if (element["urlToImage"] != null && element["description"] != null) {
            SliderModel sliderModel = SliderModel(
                element["author"],
                element["title"],
                element["description"],
                element["url"],
                element["urlToImage"],
                element["content"]);
            sliderList.add(sliderModel);
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
