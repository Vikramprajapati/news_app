import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/model/show_category_model.dart';
import 'package:flutter_news_app/screen/article_view.dart';
import 'package:flutter_news_app/service/show_category_news.dart';

class CategoryNews extends StatefulWidget {
  String name;

  CategoryNews({required this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryModel> categories_news = [];
  bool _isLoading = true;

  getCategoriesNews() async {
    ShowCategoryNews showCategoryNews = ShowCategoryNews();
    await showCategoryNews.getCategoriesNews(widget.name.toLowerCase());
    categories_news = showCategoryNews.categoriesNews;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getCategoriesNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.name,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  itemCount: categories_news.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ShowCategory(
                        image: categories_news[index].urlToImage!,
                        title: categories_news[index].title!,
                        desc: categories_news[index].description!,
                        url: categories_news[index].url!,
                      ),
                    );
                  },
                ),
              ));
  }
}

class ShowCategory extends StatelessWidget {
  String image, title, desc, url;

  ShowCategory(
      {required this.image,
      required this.title,
      required this.desc,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleView(blogUrl: url),
            ));
      },
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              title,
              maxLines: 2,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(desc,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15)),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
